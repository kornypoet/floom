module Floom
  class Status
    
    class << self
      
      def parse(status)
        new(state:         status.state,
            version:       status.version,
            last_seen:     status.lastseen,
            host:          status.host,
            physical_node: status.physicalNode,
            delta:         status.lastSeenDeltaMillis).to_hash
      end
      
    end
    
    def initialize(options = {})
      @state         = options[:node_state]
      @version       = options[:version]
      @last_seen     = options[:last_seen]
      @host          = options[:host]
      @physical_node = options[:physical_node]
      @delta         = options[:delta]
    end
    
    def to_hash
      self.instance_variables.inject({}){ |hsh, var| hsh[var.to_s.slice(1..-1).to_sym] = self.instance_variable_get(var) ; hsh }
    end
    
  end
end
