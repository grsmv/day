# coding: UTF-8

Gem::Specification.new do |s|
  s.name              = "day"
  s.version           = "0.0.1"
  s.date              = %q{2011-07-14}
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Sergey Gerasimov"]
  s.email             = ["mail@grsmv.com"]
  s.homepage          = "http://github.com/grsmv/day"
  s.summary           = "Gem for date parsing (in the scale of the day, hours is not very important in my projects now). It support Russian and Ukrainian (in future) languages."
  s.description       = "Gem for date parsing (in the scale of the day, hours is not very important in my projects now). It support Russian and Ukrainian (in future) languages."
  s.rubyforge_project = s.name
  s.files             = [
    'README.md', 
    'CHANGELOG.md', 
    'LICENSE', 
    'lib/day.rb', 
    'lib/levenshtein.rb',
    'data/month_vocabulary.yml',
    'data/short_week_days.yml',
    'data/simple_numerics.yml',
    'data/week_days.yml'
  ]

  #s.required_rubygems_version = ">= 1.3.6"
  
  # If you have runtime dependencies, add them here
  # s.add_runtime_dependency "other", "~> 1.2"
  
  # If you have development dependencies, add them here
  # s.add_development_dependency "another", "= 0.9"

  # The list of files to be contained in the gem
  # s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  #s.require_path = 'lib/week.rb'

  # For C extensions
  # s.extensions = "ext/extconf.rb"
end
