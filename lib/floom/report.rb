module Floom
  class Report

    class << self
      
      def parse(report)
        new(report.stringMetrics.merge(report.longMetrics).merge(report.doubleMetrics)).to_hash
      end

    end
    
    def initialize(report = {})
      @metrics = report
    end
    
    def to_hash
      @metrics.dup
    end
    
  end
end
