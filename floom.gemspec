$:.unshift File.expand_path('../lib', __FILE__)
require 'floom/version'

Gem::Specification.new do |s|

  s.name          = 'floom'
  s.version       = Floom::VERSION
  s.authors       = ['Travis Dempsey']
  s.email         = 'travis@infochimps.org'
  s.homepage      = 'https://github.com/kornypoet/floom.git'
  s.summary       = 'Simple Thrift class extensions for Flume'  
  s.description   = <<DESC

Flume extra fun: Floom

DESC

  s.files         = `git ls-files`.split("\n")
  s.executables   = 'bin/floom'
  s.require_paths = ['lib']
  s.add_dependency('thrift', '>= 0.8.0')
  
end
