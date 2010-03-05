require 'test/unit'
require 'webget_ruby_ramp'


class FixnumTest < Test::Unit::TestCase

  def test_even_with_true
    assert(2.even?)
  end

  def test_even_with_false
    assert(!3.even?)
  end

  def test_odd_with_true
    assert(3.odd?)
  end

  def test_odd_with_false
    assert(!2.odd?)
  end

end

