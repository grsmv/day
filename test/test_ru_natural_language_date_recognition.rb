require "test/unit"
require "day"

class DayTest < Test::Unit::TestCase

  def setup
    @today = Time.mktime(2012, 3, 22)

    def parse string
      Day::Ru.new(string, @today).parse
    end
  end

  def test_001_next_day
    assert_equal parse('завтра'), Time.mktime(2012, 3, 23)
  end
end
