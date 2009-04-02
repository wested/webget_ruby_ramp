require 'test/unit'
require 'ramp'

class TimeTest < Test::Unit::TestCase

 def test_log
  t=Time.stamp
  assert(t=~/^\d\d\d\d\d\d\d\d\d\d\d\d\d\d$/,"time format is correct")
 end

end

