require 'test/unit'
require 'webget_ramp'

class NilTest < Test::Unit::TestCase

 def test_blank
  assert_equal(true,nil.blank?)
 end

 def test_size
  assert_equal(false,nil.size?)
 end

end

