require 'test/unit'
require 'ramp'

class ObjectTest < Test::Unit::TestCase

 def test_in_array
  assert_equal(true,'a'.in?(['a','b','c']))
  assert_equal(false,'x'.in?(['a','b','c']))
 end

end

