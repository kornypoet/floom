#
# Autogenerated by Thrift Compiler (0.8.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'flumeconfig_types'


class FlumeMasterCommandThrift
  include ::Thrift::Struct, ::Thrift::Struct_Union
  COMMAND = 1
  ARGUMENTS = 2

  FIELDS = {
    COMMAND => {:type => ::Thrift::Types::STRING, :name => 'command'},
    ARGUMENTS => {:type => ::Thrift::Types::LIST, :name => 'arguments', :element => {:type => ::Thrift::Types::STRING}}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

class FlumeNodeStatusThrift
  include ::Thrift::Struct, ::Thrift::Struct_Union
  STATE = 1
  VERSION = 2
  LASTSEEN = 3
  LASTSEENDELTAMILLIS = 6
  HOST = 4
  PHYSICALNODE = 5

  FIELDS = {
    STATE => {:type => ::Thrift::Types::I32, :name => 'state', :enum_class => FlumeNodeState},
    VERSION => {:type => ::Thrift::Types::I64, :name => 'version'},
    LASTSEEN => {:type => ::Thrift::Types::I64, :name => 'lastseen'},
    LASTSEENDELTAMILLIS => {:type => ::Thrift::Types::I64, :name => 'lastSeenDeltaMillis'},
    HOST => {:type => ::Thrift::Types::STRING, :name => 'host'},
    PHYSICALNODE => {:type => ::Thrift::Types::STRING, :name => 'physicalNode'}
  }

  def struct_fields; FIELDS; end

  def validate
    unless @state.nil? || FlumeNodeState::VALID_VALUES.include?(@state)
      raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field state!')
    end
  end

  ::Thrift::Struct.generate_accessors self
end

class CommandStatusThrift
  include ::Thrift::Struct, ::Thrift::Struct_Union
  CMDID = 1
  STATE = 2
  MESSAGE = 3
  CMD = 4

  FIELDS = {
    CMDID => {:type => ::Thrift::Types::I64, :name => 'cmdId'},
    STATE => {:type => ::Thrift::Types::STRING, :name => 'state'},
    MESSAGE => {:type => ::Thrift::Types::STRING, :name => 'message'},
    CMD => {:type => ::Thrift::Types::STRUCT, :name => 'cmd', :class => FlumeMasterCommandThrift}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

