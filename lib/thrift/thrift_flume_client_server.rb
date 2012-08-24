#
# Autogenerated by Thrift Compiler (0.8.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'flumeconfig_types'

module ThriftFlumeClientServer
  class Client
    include ::Thrift::Client

    def heartbeat(logicalNode, physicalNode, host, s, timestamp)
      send_heartbeat(logicalNode, physicalNode, host, s, timestamp)
      return recv_heartbeat()
    end

    def send_heartbeat(logicalNode, physicalNode, host, s, timestamp)
      send_message('heartbeat', Heartbeat_args, :logicalNode => logicalNode, :physicalNode => physicalNode, :host => host, :s => s, :timestamp => timestamp)
    end

    def recv_heartbeat()
      result = receive_message(Heartbeat_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'heartbeat failed: unknown result')
    end

    def getConfig(sourceId)
      send_getConfig(sourceId)
      return recv_getConfig()
    end

    def send_getConfig(sourceId)
      send_message('getConfig', GetConfig_args, :sourceId => sourceId)
    end

    def recv_getConfig()
      result = receive_message(GetConfig_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getConfig failed: unknown result')
    end

    def getLogicalNodes(physNode)
      send_getLogicalNodes(physNode)
      return recv_getLogicalNodes()
    end

    def send_getLogicalNodes(physNode)
      send_message('getLogicalNodes', GetLogicalNodes_args, :physNode => physNode)
    end

    def recv_getLogicalNodes()
      result = receive_message(GetLogicalNodes_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getLogicalNodes failed: unknown result')
    end

    def getChokeMap(physNode)
      send_getChokeMap(physNode)
      return recv_getChokeMap()
    end

    def send_getChokeMap(physNode)
      send_message('getChokeMap', GetChokeMap_args, :physNode => physNode)
    end

    def recv_getChokeMap()
      result = receive_message(GetChokeMap_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getChokeMap failed: unknown result')
    end

    def acknowledge(ackid)
      send_acknowledge(ackid)
      recv_acknowledge()
    end

    def send_acknowledge(ackid)
      send_message('acknowledge', Acknowledge_args, :ackid => ackid)
    end

    def recv_acknowledge()
      result = receive_message(Acknowledge_result)
      return
    end

    def checkAck(ackid)
      send_checkAck(ackid)
      return recv_checkAck()
    end

    def send_checkAck(ackid)
      send_message('checkAck', CheckAck_args, :ackid => ackid)
    end

    def recv_checkAck()
      result = receive_message(CheckAck_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'checkAck failed: unknown result')
    end

    def putReports(reports)
      send_putReports(reports)
      recv_putReports()
    end

    def send_putReports(reports)
      send_message('putReports', PutReports_args, :reports => reports)
    end

    def recv_putReports()
      result = receive_message(PutReports_result)
      return
    end

  end

  class Processor
    include ::Thrift::Processor

    def process_heartbeat(seqid, iprot, oprot)
      args = read_args(iprot, Heartbeat_args)
      result = Heartbeat_result.new()
      result.success = @handler.heartbeat(args.logicalNode, args.physicalNode, args.host, args.s, args.timestamp)
      write_result(result, oprot, 'heartbeat', seqid)
    end

    def process_getConfig(seqid, iprot, oprot)
      args = read_args(iprot, GetConfig_args)
      result = GetConfig_result.new()
      result.success = @handler.getConfig(args.sourceId)
      write_result(result, oprot, 'getConfig', seqid)
    end

    def process_getLogicalNodes(seqid, iprot, oprot)
      args = read_args(iprot, GetLogicalNodes_args)
      result = GetLogicalNodes_result.new()
      result.success = @handler.getLogicalNodes(args.physNode)
      write_result(result, oprot, 'getLogicalNodes', seqid)
    end

    def process_getChokeMap(seqid, iprot, oprot)
      args = read_args(iprot, GetChokeMap_args)
      result = GetChokeMap_result.new()
      result.success = @handler.getChokeMap(args.physNode)
      write_result(result, oprot, 'getChokeMap', seqid)
    end

    def process_acknowledge(seqid, iprot, oprot)
      args = read_args(iprot, Acknowledge_args)
      result = Acknowledge_result.new()
      @handler.acknowledge(args.ackid)
      write_result(result, oprot, 'acknowledge', seqid)
    end

    def process_checkAck(seqid, iprot, oprot)
      args = read_args(iprot, CheckAck_args)
      result = CheckAck_result.new()
      result.success = @handler.checkAck(args.ackid)
      write_result(result, oprot, 'checkAck', seqid)
    end

    def process_putReports(seqid, iprot, oprot)
      args = read_args(iprot, PutReports_args)
      result = PutReports_result.new()
      @handler.putReports(args.reports)
      write_result(result, oprot, 'putReports', seqid)
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class Heartbeat_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    LOGICALNODE = 1
    PHYSICALNODE = 4
    HOST = 5
    S = 2
    TIMESTAMP = 3

    FIELDS = {
      LOGICALNODE => {:type => ::Thrift::Types::STRING, :name => 'logicalNode'},
      PHYSICALNODE => {:type => ::Thrift::Types::STRING, :name => 'physicalNode'},
      HOST => {:type => ::Thrift::Types::STRING, :name => 'host'},
      S => {:type => ::Thrift::Types::I32, :name => 's', :enum_class => FlumeNodeState},
      TIMESTAMP => {:type => ::Thrift::Types::I64, :name => 'timestamp'}
    }

    def struct_fields; FIELDS; end

    def validate
      unless @s.nil? || FlumeNodeState::VALID_VALUES.include?(@s)
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field s!')
      end
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Heartbeat_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::BOOL, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class GetConfig_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SOURCEID = 1

    FIELDS = {
      SOURCEID => {:type => ::Thrift::Types::STRING, :name => 'sourceId'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class GetConfig_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ThriftFlumeConfigData}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class GetLogicalNodes_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    PHYSNODE = 1

    FIELDS = {
      PHYSNODE => {:type => ::Thrift::Types::STRING, :name => 'physNode'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class GetLogicalNodes_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRING}}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class GetChokeMap_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    PHYSNODE = 1

    FIELDS = {
      PHYSNODE => {:type => ::Thrift::Types::STRING, :name => 'physNode'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class GetChokeMap_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::MAP, :name => 'success', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::I32}}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Acknowledge_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    ACKID = 1

    FIELDS = {
      ACKID => {:type => ::Thrift::Types::STRING, :name => 'ackid'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Acknowledge_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class CheckAck_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    ACKID = 1

    FIELDS = {
      ACKID => {:type => ::Thrift::Types::STRING, :name => 'ackid'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class CheckAck_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::BOOL, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class PutReports_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    REPORTS = 1

    FIELDS = {
      REPORTS => {:type => ::Thrift::Types::MAP, :name => 'reports', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::STRUCT, :class => ThriftFlumeReport}}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class PutReports_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end

