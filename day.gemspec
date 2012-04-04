# coding: UTF-8

Gem::Specification.new do |s|

  s.name = "day"
  s.version = "0.0.5"
  s.date = %q{2012-03-19}
  s.platform = Gem::Platform::RUBY
  s.authors = ["Serge Gerasimov"]
  s.email = ["mail@grsmv.com"]
  s.homepage = "http://github.com/grsmv/day"
  s.summary = "Gem for date parsing"
  s.description = "Gem for date recognition and parsing in natural language phrases."
  s.rubyforge_project = s.name

  s.add_runtime_dependency "unicode", "~> 0.4.2"

  s.files  = `git ls-files`.split($\).delete_if { |file| file =~ /^\.\w/ }
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  # s.require_paths = ["lib"]
end
