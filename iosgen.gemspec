# coding: utf-8

Gem::Specification.new do |s|
  s.name        = 'iosgen'
  s.version     = '1.0.0'
  s.summary     = 'Clean iOS architecture generator'
  s.description = 'Code generator to build a clean iOS architecture'
  s.authors     = ['Francisco J. Belchi']
  s.email       = 'dev@fjbelchi.com'
  s.homepage    = 'http://www.fjbelchi.com'
  s.license     = 'MIT'

  # Files
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(/^bin/) { |f| File.basename(f) }
  s.test_files    = s.files.grep(/^(test|spec|features)/)
  s.require_paths = ['lib']

  # Dependencies
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_dependency 'thor'
  s.add_dependency 'colorize'

  # Documentation
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md']
end
