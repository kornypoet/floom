module Floom
  class Configuration
    
    class << self

      def parse(conf)
        new(source:         conf.sourceConfig,
            sink:           conf.sinkConfig, 
            flow:           conf.flowID,            
            source_version: conf.sourceVersion,
            sink_version:   conf.sinkVersion, 
            timestamp:      conf.timestamp).to_hash
      end

      def create(options = {}, &blk)
        config = new(options)
        config.instance_eval(&blk) if block_given?
        config
      end

    end

    def initialize(options = {}) 
      @source         = options[:source]
      @sink           = options[:sink]
      @flow           = options[:flow]
      @source_version = options[:source_version]
      @sink_version   = options[:sink_version]
      @timestamp      = options[:timestamp]
    end 
    
    def timestamp(val = nil)
      @timestamp = val if val
      @timestamp
    end

    def source(val = nil)
      @source = val if val
      @source
    end

    def sink(val = nil)
      @sink = val if val
      @sink
    end

    def flow(val = nil)
      @flow = val if val
      @flow
    end

    def source_version(val = nil)
      @source_version = val if val
      @source_version
    end

    def sink_version(val = nil)
      @sink_version = val if val
      @sink_version
    end    

    def to_hash
      self.instance_variables.map{ |var| var.to_s.slice(1..-1).to_sym }.inject({}){ |hsh, var| hsh[var] = self.send(var) ; hsh }
    end

    def to_params
      [ flow, source, sink ].compact
    end
    
  end
end
