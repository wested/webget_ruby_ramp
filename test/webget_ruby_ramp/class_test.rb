require 'test/unit'
require 'webget_ruby_ramp'

class ClassTest < Test::Unit::TestCase

  
  METHOD_REGEXP = /^[abc]\W*$/
  def test_publicize_methods

    # Before we test the block, ensure our setup is correct
    assert_equal(["a","a!","a=","a?"],My.private_instance_methods.grep_sort_to_s(METHOD_REGEXP),'private methods before block')
    assert_equal(["b","b!","b=","b?"],My.protected_instance_methods.grep_sort_to_s(METHOD_REGEXP),'protected methods before block')
    assert_equal(["c","c!","c=","c?"],My.public_instance_methods.grep_sort_to_s(METHOD_REGEXP),'public methods before block')

    # Now we test inside the block
    My.publicize_methods{
      assert_equal([],My.private_instance_methods.grep_sort_to_s(METHOD_REGEXP),'private methods inside block')
      assert_equal([],My.protected_instance_methods.grep_sort_to_s(METHOD_REGEXP),'protected methods inside block')
      assert_equal(["a","a!","a=","a?","b","b!","b=","b?","c","c!","c=","c?"],My.public_instance_methods.grep_sort_to_s(METHOD_REGEXP),'public methods inside block')
    }

    # After we test the block, ensure our setup is restored
    assert_equal(["a","a!","a=","a?"],My.private_instance_methods.grep_sort_to_s(METHOD_REGEXP),'private methods before block')
    assert_equal(["b","b!","b=","b?"],My.protected_instance_methods.grep_sort_to_s(METHOD_REGEXP),'protected methods before block')
    assert_equal(["c","c!","c=","c?"],My.public_instance_methods.grep_sort_to_s(METHOD_REGEXP),'public methods before block')

  end

  protected

end


class Array
  def grep_sort_to_s(regexp)
    grep(regexp).sort.map{|x| x.to_s}
  end
end


class My

  private

  def a
  end

  def a!
  end

  def a=
  end

  def a?
  end

  protected

  def b
  end

  def b!
  end

  def b=
  end

  def b?
  end

  public

  def c
  end

  def c!
  end

  def c=
  end

  def c?
  end

end
