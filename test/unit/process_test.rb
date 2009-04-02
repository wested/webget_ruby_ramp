require 'test/unit'
require 'ramp'

class ProcessTest < Test::Unit::TestCase

 include Process

 def test_ps_text
  p=Process.ps_text
  assert(p!=nil,"ps_text != nil")
  assert(p.is_a?(String),"ps_text is a string")
 end

 def test_ps_tdf
  p=Process.ps_tdf
  assert(p!=nil,"ps_tdf != nil")
  assert(p.is_a?(String),"ps_tdf is a string")
  assert(p=~/\t/,"ps_tdf has a tab")
 end

 def test_ps_hash
  p=Process.ps_hash
  assert(p!=nil,"ps_hash != nil")
  assert(p.is_a?(Hash),"ps_hash is a hash")
  assert(p['pcpu']!=nil,"ps_hash pcpu != nil")
 end

 def test_ps
  p=Process.ps
  assert(p!=nil,"ps != nil")
  assert(p.is_a?(Hash),"ps is a hash")
  assert(p['pcpu']!=nil,"ps pcpu != nil")
  assert(p['pcpu'].is_a?(Float),"ps pcpu is a float")
 end
  
end

