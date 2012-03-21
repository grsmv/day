# coding: ASCII-8BIT

module Day
  class Ru

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

    def month_proto num
      month = num.nil? ? 1 : num.to_i
      year, mon = yield(month)
      @date = Time.mktime(year, mon, @now.day)
    end

    def next_month num
      month_proto(num) do |month|
        @now.mon + month > 12 ?
          [(@now.year + (@now.mon + month) / 12), ((@now.mon + month) % 12)] : 
          [@now.year, (@now.mon + month)]
      end
    end

    def previous_month num
      month_proto(num) do |month|
        @now.mon - month < 1 ?
          [(@now.year - (@now.mon - month) / 12 * -1), (12 - ((month - @now.mon) % 12))] :
          [@now.year, (@now.mon - month)]
      end
    end
  end
end
