require 'test/unit'
require 'webget_ramp'


class SymbolTest < Test::Unit::TestCase


  def test_comparable
    assert_equal(-1,:foo<=>:goo)
    assert_equal( 0,:foo<=>:foo)
    assert_equal( 1,:goo<=>:foo)
  end


end











