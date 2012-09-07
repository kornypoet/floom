module Floom
  class Master < Floom::Client
    
    def self.thrift_class() FlumeMasterAdminServer::Client end
    
    def configurations
      connection.getConfigs.inject({}){ |hsh, (node, conf)| hsh[node] = Floom::Configuration.parse(conf) ; hsh }
    end

    def mappings(physical_node = nil)
      connection.getMappings(physical_node)
    end
    
    def statuses
      connection.getNodeStatuses.inject({}){ |hsh, (node, stat)| hsh[node] = Floom::Status.parse(stat) ; hsh }
    end

    def logical_nodes
      (configurations.keys + mappings.values + statuses.keys).flatten.uniq
    end

    def physical_nodes
      mappings.keys
    end

    def mapped? logical_node
      mappings.values.include? logical_node
    end

    def configured? logical_node
      configurations.keys.include? logical_node
    end

    def has_status? logical_node
      statuses.keys.include? logical_node
    end

    def perform_request(*params)
      req = Floom::Request.new(connection, *params).fetch
      req.parse
    end    

    def map(physical_node, logical_node)
      perform_request(:map, physical_node, logical_node)
    end
    
    def unmap(*logical_nodes)
      logical_nodes.map do |logical_node|
        physical_node = mappings.detect(->{ mappings.keys }){ |name, nodes| nodes.include? logical_node }.first
        perform_request(:unmap, physical_node, logical_node)
      end
    end

    def unmap_all
      unmap(*logical_nodes.select{ |node| mapped? node })
    end

    def decommission(*logical_nodes)
      logical_nodes.map do |logical_node|
        perform_request(:decommission, logical_node)
      end      
    end

    def decommission_all
      decommission(*logical_nodes.select{ |node| mapped?(node) or configured?(node) })
    end

    def purge(*logical_nodes)
      logical_nodes.map do |logical_node|
        perform_request(:purge, logical_node)
      end
    end

    def purge_all
      purge(*logical_nodes.select{ |node| has_status? node })
    end

    def refresh(*logical_nodes)
      logical_nodes.map do |logical_node|
        perform_request(:refresh, logical_node)
      end      
    end
    
    def refresh_all
      refresh(*logical_nodes)
    end

    def configure(spec = {})
      spec.map do |logical_node, conf|
        params = case conf
                 when Floom::Configuration  then conf.to_params
                 when ThriftFlumeConfigData then Floom::Configuration.parse(conf).to_params
                 when Hash                  then Floom::Configuration.create(conf).to_params
                 when Array then conf
                 end          
        perform_request(:config, logical_node.to_s, *params)
      end
    end
    
    def unconfigure(*logical_nodes)
      logical_nodes.map do |logical_node|
        perform_request(:unconfig, logical_node)
      end            
    end        
  end
end
