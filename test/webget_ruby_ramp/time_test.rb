require 'test/unit'
require 'webget_ruby_ramp'

class TimeTest < Test::Unit::TestCase

 def test_stamp_with_class_method
   t=Time.stamp
   assert(t=~/^\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\dZ$/,t)
 end

 def test_stamp_with_instance_method
   t=Time.now.stamp
   assert(t=~/^\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\dZ$/,t)
 end

 def test_pack_with_class_method
   t=Time.pack
   assert(t=~/^\d\d\d\d\d\d\d\d\d\d\d\d\d\d$/,t)
 end

 def test_pack_with_instance_method
   t=Time.now.pack
   assert(t=~/^\d\d\d\d\d\d\d\d\d\d\d\d\d\d$/,t)
 end

 
end

