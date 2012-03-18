# coding: UTF-8

Gem::Specification.new do |s|

  s.name = "day"
  s.version = "0.0.3"
  s.date = %q{2012-03-20}
  s.platform = Gem::Platform::RUBY
  s.authors = ["Serge Gerasimov"]
  s.email = ["mail@grsmv.com"]
  s.homepage = "http://github.com/grsmv/day"
  s.summary = "Gem for date parsing"
  s.description = "Gem for date parsing (in the scale of the day, hours is not very important in my projects now). It support Russian and Ukrainian (in future) languages."
  s.rubyforge_project = s.name

  s.add_runtime_dependency "unicode", "~> 0.4.2" if RUBY_VERSION < "1.9"
  s.add_runtime_dependency "unicode_utils", "~> 1.3.0" if RUBY_VERSION > "1.9"
  
  s.files = [
    'README.md', 
    'CHANGELOG.md', 
    'LICENSE', 

    'lib/day.rb', 
    'lib/levenshtein.rb',
    'lib/ru/parse.rb',
    'lib/ru/parse_methods.rb',
    
    'data/month_vocabulary.yml',
    'data/short_week_days.yml',
    'data/simple_numerics.yml',
    'data/week_days.yml'
  ]
end
