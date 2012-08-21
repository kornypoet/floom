#!/usr/bin/env ruby
require 'gorillib'
require 'gorillib/pathname'

Pathname.register_path :flume_deploy, File.expand_path('..', File.dirname(__FILE__))
Pathname.register_path :bin,  :flume_deploy, 'bin'

# sudo flume node_nowatch -1 -s -n $fn_name -c "${fn_name}: $@"

def flume_node_def(fn_name, src, dest)
  "#{fn_name}: #{src} | #{dest.join(" ")};"
end

# @example run_flume_command :one_shot_a, :console, ['logSource', :console]
def run_flume_command(fn_name, src, dest, options={})
  options = options.merge(:isolated => false, :one_shot => true)
  dest = Array(dest)
  flags = []

  flags << '-n' << fn_name.to_s
  flags << '-m'
  flags << '-s'          if options[:isolated]
  # flags << '-1'          if options[:one_shot]

  args = ['flume', 'node_nowatch', *flags, '-c', flume_node_def(fn_name, src, dest)]
  p args
  system(*args)
end

name = ARGV.shift
src  = ARGV.shift
dest = ARGV

run_flume_command(name, src, dest) if $0 == __FILE__
