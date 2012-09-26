module Floom
  class Request

    attr_reader :connection, :payload

    def initialize(connection, type, *args)
      @connection = connection
      @type       = type
      @command    = FlumeMasterCommandThrift.new(command: type.to_s, arguments: args)
    end

    def fetch
      @response = connection.submit @command
      self
    end

    def parse(options = {})
      state = connection.getCmdStatus(@response).state
      
      while state == "EXECING"
        state = connection.getCmdStatus(@response).state
      end
      
      connection.getCmdStatus(@response)
      
    end

  end
end
