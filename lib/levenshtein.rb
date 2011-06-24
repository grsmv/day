#
# Levenshtein distance algorithm implementation for Ruby, with UTF-8 support
#
# Author::  Paul BATTLEY (pbattley @ gmail.com)
# Version:: 1.3
# Date::    2005-04-19
#
# == About
#
# The Levenshtein distance is a measure of how similar two strings s and t are,
# calculated as the number of deletions/insertions/substitutions needed to
# transform s into t.  The greater the distance, the more the strings differ.
#
# The Levenshtein distance is also sometimes referred to as the
# easier-to-pronounce-and-spell 'edit distance'.
#
# == Revision history
#
# * 2005-05-19 1.3 Repairing an oversight, distance can now be called via
#   Levenshtein.distance(s, t)
# * 2005-05-04 1.2 Now uses just one 1-dimensional array.  I think this is as
#   far as optimisation can go.
# * 2005-05-04 1.1 Now storing only the current and previous rows of the matrix
#   instead of the whole lot.
#
# == Licence
#
# Copyright (c) 2005 Paul Battley
#
# Usage of the works is permitted provided that this instrument is retained
# with the works, so that any entity that uses the works is notified of this
# instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.  
#

class Levenshtein

    #
    # Calculate the Levenshtein distance between two strings +str1+ and +str2+.
    # +str1+ and +str2+ should be ASCII or UTF-8.
    #
    class << self

      def distance(str1, str2)
          s, t = str1.unpack('U*'), str2.unpack('U*')
          n, m = s.length, t.length
          return m if (0 == n)
          return n if (0 == m)
          
          d = (0..m).to_a
          x = nil

          (0...n).each do |i|
              e = i+1
              (0...m).each do |j|
                  cost = (s[i] == t[j]) ? 0 : 1
                  x = [
                      d[j+1] + 1, # insertion
                      e + 1,      # deletion
                      d[j] + cost # substitution
                  ].min
                  d[j] = e
                  e = x
              end
              d[m] = x
          end

          return x
      end
    end
end

#@needle = 'послзвтр'

#@haystack = %w( завтра сегодня вчера позавчера послезавтра январь февраль март апрель май июнь июль август сентябрь октябрь ноябрь декабрь апр)

#words = {}
#for word in @haystack
  #words[Levenshtein.distance(@needle, word).to_i] = word
#end

#puts "Closest to #{@needle} word is #{words.sort.flatten[1]}"
