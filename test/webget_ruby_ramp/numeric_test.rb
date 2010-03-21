require 'test/unit'
require 'webget_ruby_ramp'

class NumericTest < Test::Unit::TestCase


  def test_if_with_true
    assert_equal(5,5.if(true))
  end


  def test_if_with_false
    assert_equal(0,5.if(false))
  end


  def test_unless_with_true
    assert_equal(0,5.unless(true))
  end


  def test_unless_with_false
    assert_equal(5,5.unless(false))
  end

  
end

