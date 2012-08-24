$:.unshift File.expand_path('../thrift', __FILE__)

require 'thrift/flume_master_admin_server'
require 'thrift/flume_constants'
require 'thrift/flumeconfig_constants'
require 'thrift/flumereportserver_constants'
require 'thrift/mastercontrol_constants'
require 'thrift/thrift_flume_client_server'
require 'thrift/thrift_flume_event_server'
require 'thrift/thrift_flume_report_server'

require 'floom/client'
