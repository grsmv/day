$KCODE = 'u'

require 'date'
require 'iconv'


class Numeric
  def days
    self * 60 * 60 * 24
  end
end

module Day

  class Ru

    @@short_week_days = %w(nil пн вт ср чт пт сб вс)
    @@week_days = %w(nil понедельник вторник среду черверг пятницу субботу воскресенье)

    @@days_in_month = [
      31, (Date.new(Time.now.year, 1, 1).leap? ? 29 : 28), 31, 30, 31, 30, 
      31, 31, 30, 31, 30, 31
    ]

    @@simple_numerics = {
      'один'   => 1, 'одну'   => 1, 'два'    => 2,
      'две'    => 2, 'три'    => 3, 'четыре' => 4,
      'пять'   => 5, 'шесть'  => 6, 'семь'   => 7,
      'восемь' => 8, 'девять' => 9, 'десять' => 10
    }

    @@month_vocabulary = {
      'янв' => 'jan', 'фев' => 'feb', 'мар' => 'march',
      'апр' => 'apr', 'май' => 'may', 'мая' => 'may',
      'июн' => 'jun', 'июл' => 'jul', 'авг' => 'aug',
      'сен' => 'sep', 'окт' => 'oct', 'нояб' => 'nov',
      'дек' => 'dec'
    }

    # TODO: string to utf8 if Ruby version > 1.9
    # TODO: convert to lowercase with Unicode gem
    def initialize string
      @string = string.strip
      @now = Time.now
      @week_start = @now - @now.wday.days
    end

    attr_accessor :date

    private


    def yesterday_today_tomorrow
      @date = case @string
        when /^(позавчера)$/ then @now - 2.days
        when /^(вчера)$/ then @now - 1.days
        when /^(завтра)$/ then @now + 1.days
        when /^(послезавтра)$/ then @now + 2.days
        else @now
      end
    end


    def future_days days_num
      @date = @now + days_num.to_i.days
    end


    def previous_days days_num
      @date = @now - days_num.to_i.days
    end


    def in_week_day day
      @date = @week_start + @@week_days.index(day).days
    end


    def in_week_day_short_notation day
      @date = @week_start + @@short_week_days.index(day).days
    end


    def in_past_week_day day
      @date = in_week_day(day) - 7.days
    end


    def in_next_week_day day
      @date = in_week_day(day) + 7.days
    end


    def next_weeks weeks_num
      weeks = weeks_num.nil? ? 1 : weeks_num.to_i
      @date = @now + (weeks * 7).days
    end


    def previous_weeks weeks_num
      weeks = weeks_num.nil? ? 1 : weeks_num.to_i
      @date = @now - (weeks * 7).days
    end


    def next_month month_number
      month = month_number.nil? ? 1 : month_number.to_i

      if @now.mon + month > 12
        mon = (@now.mon + month) % 12
        year = @now.year + (@now.mon + month) / 12
      else
        mon, year = (@now.mon + month), @now.year
      end

      @date = Time.mktime(year, mon, @now.day)
    end


    def previous_month month_number
      month = month_number.nil? ? 1 : month_number.to_i

      if @now.mon - month < 1
        mon = 12 - ((month - @now.mon) % 12)
        year = @now.year - (@now.mon - month) / 12 * -1
      else
        mon, year = (@now.mon - month), @now.year
      end

      @date = Time.mktime(year, mon, @now.day)
    end

    public

    def parse
      case @string
       
        # вчера
        # сегодня
        # завтра
        when /^(позавчера|вчера|сегодня|завтра|послезавтра)$/i
          yesterday_today_tomorrow

        # через 1 день
        # через 2 дня
        # через 5 дней
        when /^через\s(\d{1,})\sд(н(|я|ей)|ень)$/i
          future_days $1

        # через один день
        # через два дня
        # через пять дней
        when /^через\s(#{@@simple_numerics.keys.join('|')})\sд(н(|я|ей)|ень)$/
          future_days @@simple_numerics[$1]

        # 1 день назад
        # 2 дня назад
        # 5 дней назад
        when /^(\d{1,})\sд(н(|я|ей)|ень)\sназад/i
          previous_days $1

        # два дня назад
        # пять дней назад
        when /^(#{@@simple_numerics.keys.join('|')})\sд(н(|я|ей)|ень)\sназад$/
          previous_days @@simple_numerics[$1]

        # в понедельник
        # во вторник
        # в воскресенье
        # в эту среду
        when /^во?\s(эт(о|от|у)\s)?(#{@@week_days.join('|')})$/i
          in_week_day $3

        # пн (вт ... вс)
        when /^(#{@@short_week_days.join('|')})$/i
          in_week_day_short_notation $1

        # в прошлый понедельник
        # в прошлую среду
        # в прошлое воскресенье
        when /^в\sпрошл(ый|ую|ое)\s(#{@@week_days.join('|')})/i
          in_past_week_day $2

        # в следующий понедельник
        # в следующую пятницу
        # в следующее воскресенье
        when /^в\sследующ(ий|ую|ее)\s(#{@@week_days.join('|')})/i
          in_next_week_day $2

        # через неделю
        # через 1 неделю
        # через 2 недели
        # через 5 недель
        when /^через\s(\d{1,})?\s?недел(и|ю|ь)$/i
          next_weeks $1

        # через две недели
        # через десять недель
        when /^через\s(#{@@simple_numerics.keys.join('|')})\sнедел(и|ю|ь)$/
          next_weeks @@simple_numerics[$1]

        # неделю назад
        # 1 неделю назад
        # 2 недели назад
        # 5 недель назад
        when /^(\d{1,})?\s?недел(и|ю|ь)\sназад$/i
          previous_weeks $1

        # две недели назад
        # десять недель назад
        when /^(#{@@simple_numerics.keys.join('|')})\sнедел(и|ю|ь)\sназад$/
          previous_weeks @@simple_numerics[$1]

        # через месяц
        # через 1 месяц
        # через 2 месяца
        # через 5 месяцев
        when /^через\s(\d{1,})?\s?месяц(|а|ев)$/i
          next_month $1

        # через два месяца
        # через десять месяцев
        when /^через\s(#{@@simple_numerics.keys.join('|')})\sмесяц(|а|ев)$/i
          next_month @@simple_numerics[$1]

        # месяц назад
        # 1 месяц назад
        # 2 месяца назад
        # 5 месяцев назад
        when /^(\d{1,})?\s?месяц(|а|ев)\sназад$/i
          previous_month $1

        # два месяца назад
        # десять месяцев назад
        when /^(#{@@simple_numerics.keys.join('|')})\sмесяц(|а|ев)\sназад$/i
          previous_month @@simple_numerics[$1]

        # 2 октября, 2 окт, 2 окт 2011
        else
          if @string =~ /\s?(#{@@month_vocabulary.keys.join('|')})/
            @string.gsub!($1, @@month_vocabulary[$1])
          end

          begin
            tmp_date = Date.parse @string
            @date = Time.mktime(tmp_date.year, tmp_date.mon, tmp_date.day)

          # TODO: raise an error: Date not recognized
          rescue => err
            puts err
          end
      end

      @date
    end

  end
end

# API simplifier
def Day::Ru string
  Day::Ru.new(string).parse
end

    #  1.05.2011
    #  01.05.2011
    #  1-5-2011
    #  2011-5-1
    #  2011.5.1
    #  2011.1 (!!!)
p Day::Ru 'через 2 дня'
