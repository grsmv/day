# coding: utf-8

require "test/unit"
require "day"

class Numeric
  def days
    self * 60 * 60 * 24
  end

  def to_time
    Time.at(self)
  end
end

class DayTest < Test::Unit::TestCase

  def setup
    @today = Time.mktime(2012, 3, 22, 0, 0)

    def parse string
      Day::Ru.new(string, @today).parse
    end

    def today
      @today.to_i
    end
  end

  #
  # yesterday_today_tomorrow
  # ========================

  def test_001_tomorrow
    assert_equal parse('завтра'), (today + 1.days).to_time
  end
  
  def test_002_today
    assert_equal parse('сегодня'), (today).to_time
  end

  def test_003_yesterday
    assert_equal parse('вчера'), (today - 1.days).to_time
  end

  def test_004_day_after_tomorrow
    assert_equal parse('послезавтра'), (today + 2.days).to_time
  end

  def test_005_day_before_yesterday
    assert_equal parse('позавчера'), (today - 2.days).to_time
  end

  #
  # future_days
  # ===========

  def test_006_since_1_day
    assert_equal parse('через 1 день'), (today + 1.days).to_time
  end

  def test_007_since_day
    assert_equal parse('через день'), (today + 1.days).to_time
  end

  def test_008_since_2_days
    assert_equal parse('через 2 дня'), (today + 2.days).to_time
  end

  def test_009_since_10_days
    assert_equal parse('через 10 дней'), (today + 10.days).to_time
  end

  def test_010_since_one_day
    assert_equal parse('через один день'), (today + 1.days).to_time
  end

  #
  # previous_days
  # =============
  def test_011_1_day_ago
    assert_equal parse('1 день назад'), (today - 1.days).to_time
  end 

  def test_012_2_days_ago
    assert_equal parse('2 дня назад'), (today - 2.days).to_time
  end 

  def test_013_5_days_ago
    assert_equal parse('5 дней назад'), (today - 5.days).to_time
  end 

  def test_014_two_days_ago
    assert_equal parse('два дня назад'), (today - 2.days).to_time
  end 

  def test_015_five_days_ago
    assert_equal parse('пять дней назад'), (today - 5.days).to_time
  end 

  def test_016_done_nothing
    # assert_equal parse('пять дней назад'), (today - 5.days).to_time
  end
end
