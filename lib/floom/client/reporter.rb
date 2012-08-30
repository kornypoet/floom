module Floom
  class Reporter < Client

    def self.thrift_class() ThriftFlumeReportServer::Client ; end

    def reports
      connection.getAllReports.inject({}){ |hsh, (name, report)| hsh[name] = Floom::Report.parse(report) ; hsh }
    end

  end
end
