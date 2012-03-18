$KCODE = 'u'

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

module Day

  class Ru

    # getting class variables from 'data' folder contents
    Dir.glob('../data/*.yml') do |yml|
      class_variable_set(
        "@@#{yml.gsub('.yml', '')}".to_sym, YAML::load(File.read(yml))
      )
    end

    # TODO: - string to utf8 if Ruby version > 1.9
    #       - convert to lowercase with Unicode gem
    #       - set date
    def initialize string
      @string = string.strip
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