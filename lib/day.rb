# coding: utf-8
# $KCODE = 'u'

$LOAD_PATH << '.'

require 'date'
require 'iconv'
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
end

module Day

  class Ru

    # getting class variables from 'data' folder contents
    Dir.glob('../data/*.yml') do |yml|
      class_variable_set(
        "@@#{yml.gsub(/(\.\.\/data\/|\.yml)/, '')}".to_sym, YAML::load(File.read(yml))
      )
    end

    # TODO: - string to utf8 if Ruby version > 1.9
    #       - convert to lowercase with Unicode gem
    #       - set date
    def initialize string
      @string = string.strip.encode!
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

p Day::Ru('во вторник')