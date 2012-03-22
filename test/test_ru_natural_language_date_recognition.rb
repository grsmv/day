# coding: utf-8

require "test/unit"
require "day"

class DayTest < Test::Unit::TestCase

  def setup
    @today = Time.mktime(2012, 3, 22, 0, 0)

    def parse string
      Day::Ru.new(string, @today).parse
    end
  end

  #
  # yesterday_today_tomorrow method testing
  #

  def test_001_tomorrow
    assert_equal parse('завтра'), Time.mktime(2012, 3, 23)
  end
  
  def test_002_today
    assert_equal parse('сегодня'), Time.mktime(2012, 3, 22)
  end

  def test_003_yesterday
    assert_equal parse('вчера'), Time.mktime(2012, 3, 21)
  end

  def test_004_day_after_tomorrow
    assert_equal parse('послезавтра'), Time.mktime(2012, 3, 24)
  end

  def test_005_day_before_yesterday
    assert_equal parse('позавчера'), Time.mktime(2012, 3, 20)
  end

  #
  #  future_days method testing
  #

  def test_006_since_1_day
    assert_equal parse('через 1 день'), Time.mktime(2012, 3, 23)
  end

  def test_007_since_day
    assert_equal parse('через день'), Time.mktime(2012, 3, 23)
  end

  def test_008_since_2_days
    assert_equal parse('через 2 дня'), Time.mktime(2012, 3, 24)
  end

  def test_009_since_10_days
    assert_equal parse('через 10 дней'), Time.mktime(2012, 4, 1, 01, 00)
  end

end
