module Floom
  class Report

    class << self
      
      def parse(report)
        new(report.stringMetrics.merge(report.longMetrics).merge(report.doubleMetrics)).to_hash
      end

    end
    
    def initialize(options = {})
      @metrics = options
    end

    def to_hash
      @metrics.dup
    end
    
  end
end
