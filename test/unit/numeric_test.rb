require 'test/unit'
require 'ramp'

class NumericTest < Test::Unit::TestCase


  def test_if_with_true
    assert_equal(5,5.if(true))
  end


  def test_if_with_false
    assert_equal(0,5.if(false))
  end


  def test_if_not_with_true
    assert_equal(0,5.if_not(true))
  end


  def test_if_not_with_false
    assert_equal(5,5.if_not(false))
  end


end

