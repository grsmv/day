# coding: utf-8

if RUBY_VERSION < "1.9"
  $KCODE = 'u'
  require 'rubygems'
else
  $LOAD_PATH << '.'
end

require 'unicode'
require 'date'
require 'yaml'
require 'day/ru/parse'
require 'day/ru/parse_methods'

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
    ::Unicode::downcase(self)
  end
end

module Day

  class Ru

    attr_accessor :date

    # getting class variables from 'data' folder contents
    Dir.glob('data/ru/*.yml') do |yml|
      class_variable_set(
        "@@#{yml.gsub(/(data\/ru\/|\.yml)/, '')}".to_sym, YAML::load(File.read(yml))
      )
    end

    # Initalizing new object
    #
    # @param [String] string natural language date designation
    # @param [Time] now date to count from
    def initialize(string, now = Time.now)
      @string, @now = string.strip.to_downcase.encode!, now
      @week_start = @now - @now.wday.days
    end
  end
end

# API simplifier
def Day::Ru string
  Day::Ru.new(string).parse
end
