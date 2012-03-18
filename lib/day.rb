# coding: utf-8

if RUBY_VERSION < "1.9"
  $KCODE = 'u'
  require 'rubygems'
  require 'unicode'
else
  $LOAD_PATH << '.'
  require 'unicode_utils'
end

require 'date'
require 'yaml'
require 'ru/parse'
require 'ru/parse_methods'

class Numeric
  def days
    self * 60 * 60 * 24
  end
end

##
#  Force encoding change for Ruby 1.9
#  for more information see http://goo.gl/alaUM
#
class String
  def encode!
    (defined?(Encoding) && self.respond_to?(:force_encoding)) ? 
      self.force_encoding('ASCII-8BIT') : self
  end

  def to_downcase
    (RUBY_VERSION < "1.9") ? 
      ::Unicode::downcase(self) : ::UnicodeUtils.downcase(self)
  end
end

module Day

  class Ru

    # getting class variables from 'data' folder contents
    Dir.glob('../data/*.yml') do |yml|
      class_variable_set(
        "@@#{yml.gsub(/(\.\.\/data\/|\.yml)/, '')}".to_sym, YAML::load(File.read(yml))
      )
    end

    def initialize string
      @string = string.strip.to_downcase.encode!
      @now = Time.now
      @week_start = @now - @now.wday.days
    end

    attr_accessor :date
  end
end

# API simplifier
def Day::Ru string
  Day::Ru.new(string).parse
end
