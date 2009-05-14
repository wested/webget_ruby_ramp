equire 'test/unit'
require 'ramp'

class IntegerTest < Test::Unit::TestCase

  def test_yields
    expect=['a','a','a']
    actual=3.yields{'a'}
    assert_equal(expect,actual)
  end

end

