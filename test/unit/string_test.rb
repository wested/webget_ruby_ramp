require 'test/unit'
require 'ramp'


class StringTest < Test::Unit::TestCase


  def test_lowcase
    assert_equal('foo_goo_hoo',"Foo GOO**_**Hoo".lowcase)
  end


  def test_words
    assert_equal(['foo','goo','hoo'],"foo goo hoo".words)
  end


  def test_split_tab
    assert_equal(['foo','goo','hoo'],"foo\tgoo\thoo".split_tab)
  end

  
  def test_capitalize_words
    assert_equal("Foo Goo Hoo","foo goo hoo".capitalize_words)
  end


  def test_to_class
    assert_equal(String,'String'.to_class)
  end


  def test_to_class_nested
    assert_equal(FooModule::FooClass,'FooModule::FooClass'.to_class)
  end


  def test_increment
    assert_equal('5','4'.increment,               'number is entire string')
    assert_equal('5foo','4foo'.increment,         'number is leftmost')
    assert_equal('foo5','foo4'.increment,         'number is rightmost')
    assert_equal('foo10','foo9'.increment,        'number is rightmost with carry')
    assert_equal('foo5bar','foo4bar'.increment,   'number is in then middle')
    assert_equal('foobar','foobar'.increment,     'no number, so should be unchanged')
  end


  def test_decrement
    assert_equal('3','4'.decrement,               'number is entire string')
    assert_equal('3foo','4foo'.decrement,         'number is leftmost')
    assert_equal('foo3','foo4'.decrement,         'number is rightmost')
    assert_equal('foo9','foo10'.decrement,        'number is rightmost with carry')
    assert_equal('foo3bar','foo4bar'.decrement,   'number is in then middle')
    assert_equal('foobar','foobar'.decrement,     'no number, so should be unchanged')
  end


  def test_prev_char
    assert_equal(["-",false,false] ,String.prev_char("-"))  #unchanged
    assert_equal(["5",true,false]  ,String.prev_char("6"))  #numeric typical
    assert_equal(["9",true,true]   ,String.prev_char("0"))  #numeric carry
    assert_equal(["m",true,false]  ,String.prev_char("n"))  #lowercase typical
    assert_equal(["z",true,true]   ,String.prev_char("a"))  #lowercase carry
    assert_equal(["M",true,false]  ,String.prev_char("N"))  #uppercase typical
    assert_equal(["Z",true,true]   ,String.prev_char("A"))  #uppercase carry
  end


  def test_prev
    assert_equal('n-','n-'.prev)     # unchanged
    assert_equal('n5','n6'.prev)     # numeric typical
    assert_equal('m9','n0'.prev)     # numeric carry
    assert_equal('m999','n000'.prev) # numeric carries
    assert_equal('ne','nf'.prev)     # lowercase typical
    assert_equal('mz','na'.prev)     # lowercase carry
    assert_equal('mzzz','naaa'.prev) # lowercase carries
    assert_equal('NE','NF'.prev)     # uppercase typical
    assert_equal('MZ','NA'.prev)     # uppercase carry
    assert_equal('MZZZ','NAAA'.prev) # uppercase carries
  end

  def test_lorem_length
    x = String.lorem_length
    assert(x.is_a?(Integer),'x is integer')
    assert(x>0,"x:#{x}>0")
    assert(x<=20,"x:#{x}<=20")
  end

  def test_lorem
    s = String.lorem
    assert(s.is_a?(String),'s is string')
    assert(s.size>0,"s.size:#{s.size}>0")
    assert(s.size<20,"s.size:#{s.size}<=20")
  end

  def test_lorem_with_length
    s = String.lorem(5)
    assert(s.is_a?(String),'s is string')
    assert(s.size==5,"s.size:#{s.size}==5")
  end

end


# For testing #to_class
module FooModule #:nodoc: all
  class FooClass
  end
end











