module Floom
  class Client

    def self.create(type, options = {})
      
    end

    def initialize(options = {})
      @port        = options[:port]
      @host        = options[:host]
      thrift_class = lookup_thrift_class(options[:type])
      thrift_client(thrift_class, thrift_protocol(thrift_transport(thrift_socket)))
    end
    
    def open
      thrift_transport.open
    end

  private

    def lookup_thrift_class(key)
      {
        master: FlumeMasterAdminServer::Client,        
        report: ThriftFlumeReportServer::Client
      }.fetch(key)
    end

    def thrift_socket(host, port)
      @socket    ||= Thrift::Socket.new(host, port)
    end

    def thrift_transport(socket)
      @transport ||= Thrift::BufferedTransport.new(socket)
    end

    def thrift_protocol
      @protocol  ||= Thrift::BinaryProtocol.new(transport)      
    end
    
    def thrift_client(thrift_klass, protocol)
      @client    ||= thrift_klass.new(protocol)
    end

  end
  
  class Master < Client
    
  end

  class Reporter < Client

  end

end
