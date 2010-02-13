require 'test/unit'
require 'webget_ruby_ramp'

class KernelTest < Test::Unit::TestCase

 def test_method_name
  assert_equal('test_method_name',method_name)
 end

 def test_pp_s
  assert_equal(":foo\n",pp_s(:foo))
 end

end

