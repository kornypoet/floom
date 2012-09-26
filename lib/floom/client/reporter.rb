module Floom
  class Reporter < Client

    def self.thrift_class() ThriftFlumeReportServer::Client ; end

    def reports
      connection.getAllReports.inject({}){ |hsh, (name, report)| hsh[name] = Floom::Report.parse(report) ; hsh }
    end

    def extract_master(metrics)
      master_key = metrics.keys.detect{ |key| key =~ /^flume-master-\d+$/ }
      master     = metrics.delete(master_key) || {}
      master.delete('name')
      { master: master }
    end

    def extract_system_info(metrics, namespace = 'null')
      system_info_key = metrics.keys.detect{ |key| key =~ /^#{namespace}\.system-info$/ }
      system_info     = metrics.delete(system_info_key) || {}
      system_info.delete('name')
      { system_info: system_info }
    end

    def extract_jvm_info(metrics, namespace = 'null')
      jvm_info_key = metrics.keys.detect{ |key| key =~ /^#{namespace}\.jvm-Info$/ }
      jvm_info     = metrics.delete(jvm_info_key) || {} 
      jvm_info.delete('name')
      { jvm_info: jvm_info }
    end

    def extract_logical_nodes(metrics, physical_node)
      logical_node_keys = metrics.keys.map{ |key| key.match(/^#{physical_node}\.(?<node_name>[\w-]+)\.(?<metric>[\w-.]+)$/) }.compact
      logical_nodes  = logical_node_keys.inject({}) do |hsh, node_key|
        logical_node = node_key[:node_name]
        metric_key   = node_key[:metric]
        hsh[logical_node] = {} unless hsh[logical_node]
        hsh[logical_node].merge!(metric_key => metrics.delete(node_key.to_s))
        hsh
      end
      { logical_nodes: logical_nodes }
    end

    def extract_physical_nodes(metrics)
      physical_node_keys = metrics.keys.map{ |key| key.match(/^pn-(?<node_name>[\w-]+)$/) }.compact
      physical_nodes   = physical_node_keys.inject({}) do |hsh, node_key|
        node_name      = node_key[:node_name]
        hsh[node_name] = {} unless hsh[node_name]
        hsh[node_name].merge!(metrics.delete(node_key.to_s)).
          merge!(extract_system_info(metrics, node_key.to_s)).
          merge!(extract_jvm_info(metrics, node_key.to_s)).
          merge!(extract_logical_nodes(metrics, node_name))
        hsh
      end
      { physical_nodes: physical_nodes }
    end

    def rehash(metrics = reports)
      {}.merge!(extract_master metrics).
        merge!(extract_jvm_info metrics).
        merge!(extract_system_info metrics).
        merge!(extract_physical_nodes metrics)
    end  
  end
end
