[![Build Status](https://secure.travis-ci.org/grsmv/day.png?branch=master)](http://travis-ci.org/grsmv/day)

Gem for date parsing (in the scale of the day, hours is not very important in my projects now). It support Russian and Ukrainian (in future) languages.

[Table of possible phrases to recognize](https://github.com/grsmv/day/wiki/%D0%92%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D1%8B%D0%B5-%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D1%8F)

USAGE:
-----
    puts Day::Ru 'через 2 месяца'  #=> Wed Sep 14 00:00:00 +0300 2011
    puts Day::Ru 'завтра'          #=> Wed Jul 15 00:00:00 +0300 2011

    # also you can define date to start counting from:
    start_day = Time.mktime(2015, 8, 30)
    puts Day::Ru.new('в следующий вторник', start_day).parse
