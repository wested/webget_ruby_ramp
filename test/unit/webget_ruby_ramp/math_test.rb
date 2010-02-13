require 'test/unit'
require 'webget_ruby_ramp'

class MathTest < Test::Unit::TestCase

  def test_ln
    assert_equal(1.0,Math.ln(Math.exp(1.0)))
  end

  def test_logn
    assert_equal(1.0,Math.logn(3,3),'log of 3 base 3')
    assert_equal(2.0,Math.logn(9,3),'log of 9 base 3')
    assert_equal(3.0,Math.logn(27,3),'log of 27 base 3')
  end

end

