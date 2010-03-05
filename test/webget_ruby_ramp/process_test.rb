require 'test/unit'
require 'webget_ruby_ramp'

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

 def test_ps_aliases
   assert(Process.ps_aliases.is_a?Hash)
 end

 def test_ps_aliases_default
   assert(Process::PS_ALIASES_DEFAULT.is_a?Hash)
 end

 def test_ps_aliases_eq
   Process.ps_aliases={'a'=>'b', 'c'=>'d'}
   assert_equal({'a'=>'b', 'c'=>'d'}, Process.ps_aliases)
   Process.ps_aliases=Process::PS_ALIASES_DEFAULT
 end

 def test_ps_command
   assert(Process.ps_command.is_a?String)
 end

 def test_ps_command_default
   assert(Process::PS_COMMAND_DEFAULT.is_a?String)
 end

 def test_ps_command_eq
   Process.ps_command='abc'
   assert_equal('abc', Process.ps_command)
   Process.ps_command=Process::PS_COMMAND_DEFAULT
 end

 def test_ps_keys
   assert(Process.ps_keys.is_a?Array)
 end

 def test_ps_keys_default
   assert(Process::PS_KEYS_DEFAULT.is_a?Array)
 end

 def test_ps_keys_eq
   Process.ps_keys=['a','b','c']
   assert_equal(['a','b','c'], Process.ps_keys)
   Process.ps_keys=Process::PS_KEYS_DEFAULT
 end
  
end

