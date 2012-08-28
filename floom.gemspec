Gem::Specification.new do |s|

  s.name    = 'floom'
  s.version = Floom::Version
  s.authors = ['kornypoet']
  s.email   = 'travis@infochimps.org'
  s.summary = ''  
  s.description = <<DESC

Flume extra fun: Floom

DESC

  s.files   = `git ls`.split("\n")
  s.add_dependency('thrift')
  
end
