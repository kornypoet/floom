module Floom
  class Client

    attr_reader :connection

    def initialize(options = {})
      @host = options[:host]
      @port = options[:port]
      establish_connection!
    end
    
    def to_s
      "#<#{self.class}:#{object_id} host:#{@host} port:#{@port}>"
    end

    def reset_connection!
      @socket = @transport = @protocol = @connection = nil
      establish_connection!
    end

  private
    
    def establish_connection!
      @socket     ||= Thrift::Socket.new(@host, @port)
      @transport  ||= Thrift::BufferedTransport.new(@socket)
      @protocol   ||= Thrift::BinaryProtocol.new(@transport)      
      @connection ||= self.class.thrift_class.new(@protocol)
      @transport.open
      self
    end

  end
end
