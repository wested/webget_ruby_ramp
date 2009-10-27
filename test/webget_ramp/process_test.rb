require 'test/unit'
require 'webget_ramp'

class ProcessTest < Test::Unit::TestCase

 include Process

 def test_ps
  p=Process.ps
  assert(p!=nil,"ps != nil")
  assert(p.is_a?(String),"ps is a string")
  assert(p.size>0,"ps size > 0")
 end

 def test_pss
  p=Process.pss
  assert(p!=nil,"pss != nil")
  assert(p.is_a?(Hash),"ps_hash is a hash")
  assert(p.size>0,"pss size > 0")
  assert(p['pcpu']!=nil,"ps_hash pcpu != nil")
 end
  
end

