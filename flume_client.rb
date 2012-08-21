module Hanuman
  class FlumeClient

    attr_reader :master
    
    def initialize master
      @master = master
    end
    
    def process_running? proc
      !%x[ ps aux | grep "[F]lume#{proc}" ].strip.empty?
    end
    
    def shell_response cmd
      Open3.popen3('flume','shell','-c',master,'-e',cmd){ |stdin, stdout, stderr, thread| stdout.read }
    end
    
    def config
      return @config if @config
      response = shell_response "getconfigs"
      trimmed  = response.split(/SOURCE\s+SINK\s+/)[1..-1].map{ |s| s.split(/\n/) }.flatten.compact_blank
      logical  = trimmed.inject([]) do |ary,str| 
        vals   = str.split(/\s/).compact_blank.map(&:strip)
        ary << { vals.shift => { :flow => vals.shift, :source => vals.shift, :sink => vals.shift } }
      end
      @config = { :logical_nodes => logical }
    end
    
    def status
      return @status if @status
      response = shell_response "getnodestatus"
      trimmed  = response.split(/\d+\s+nodes\s+/)[1..-1].map{ |s| s.split(/\n/) }.flatten.compact_blank
      logical  = trimmed.inject([]) do |ary,str|
        vals   = str.split(/-->/).map(&:strip)
        ary << { vals.shift => { :status => vals.shift.downcase.to_sym } }
      end
      @status ={ :logical_nodes => logical }
    end
    
    def mapping
      return @mapping if @mapping
      response = shell_response "getmappings"
      trimmed  = response.split(/Logical Node\(s\)\s+/)[1..-1].map{ |s| s.split(/\n/) }.flatten.compact_blank
      physical = trimmed.inject([]) do |ary,str|
        vals   = str.split(/-->/).map(&:strip)
        ary << { vals.shift => { :logical_nodes => vals.shift[1..-2].split(',') } }
      end
      @mapping = { :physical_nodes => physical }
    end
    
    def report
      return @report if @report
      response = shell_response "getreports"
      trimmed  = response.split(/\d+\s+reports\s+/)[1..-1].map{ |s| s.split(/\n/) }.flatten.compact_blank
      reports  = trimmed.inject({}) do |hsh,str|
        vals   = str.split(/-->/).map(&:strip)
        ary << { vals.shift => { "ThriftFlumeReport" => vals.shift.match(/ThriftFlumeReport\((.*)\)/).captures.first } }
      end
      @report = { :reports => reports }
    end
    
    def refresh!
      @config = @node = @mapping = @report = nil
    end
    
  end
end

