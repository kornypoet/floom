module Floom
  class Reporter < Client

    def self.thrift_class() ThriftFlumeReportServer::Client ; end

  end
end
