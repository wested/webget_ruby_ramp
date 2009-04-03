require 'test/unit'
require 'ramp'

class EnumerableTest < Test::Unit::TestCase

  ITEMS = ['a','b','c']


  ########################################################################
  #
  #  map
  #
  ########################################################################


  class Mock #:nodoc: all
    attr_accessor :id
    def initialize(id)
      @id=id
    end
  end


  A = Mock.new('a') 
  B = Mock.new('b') 
  C = Mock.new('c') 


  def test_map_id
    assert_equal(['a','b','c'],[A,B,C].map_id)
  end


  def test_map_to_sym
    assert_equal([:a,:b,:c],ITEMS.map_to_sym)
  end


  ########################################################################
  #
  #  select
  #
  ########################################################################


  def test_select_while
    assert_equal([           ],ITEMS.select_while{|x| x < 'a' },'< a')
    assert_equal(['a'        ],ITEMS.select_while{|x| x < 'b' },'< b')
    assert_equal(['a','b'    ],ITEMS.select_while{|x| x < 'c' },'< c')
    assert_equal(['a','b','c'],ITEMS.select_while{|x| x < 'd' },'< d')
    assert_equal(['a','b','c'],ITEMS.select_while{|x| x < 'e' },'< e')
  end


  def test_select_until_condition
    assert_equal([           ],ITEMS.select_until{|x| x == 'a' },'a')
    assert_equal(['a'        ],ITEMS.select_until{|x| x == 'b' },'b')
    assert_equal(['a','b'    ],ITEMS.select_until{|x| x == 'c' },'c')
    assert_equal(['a','b','c'],ITEMS.select_until{|x| x == 'd' },'d')
    assert_equal(['a','b','c'],ITEMS.select_until{|x| x == 'e' },'e')
  end


  def test_select_with_index
    assert_equal([           ],ITEMS.select_with_index{|x,i| i < 0 },'i < 0')
    assert_equal(['a'        ],ITEMS.select_with_index{|x,i| i < 1 },'i < 1')
    assert_equal(['a','b'    ],ITEMS.select_with_index{|x,i| i < 2 },'i < 2')
    assert_equal(['a','b','c'],ITEMS.select_with_index{|x,i| i < 3 },'i < 3')
    assert_equal(['a','b','c'],ITEMS.select_with_index{|x,i| i < 4 },'i < 4')
  end


  ########################################################################
  #
  #  nitems
  #
  ########################################################################


  def test_nitems_while  
    assert_equal(0,ITEMS.nitems_while{|x| x < 'a' },'< a')
    assert_equal(1,ITEMS.nitems_while{|x| x < 'b' },'< b')
    assert_equal(2,ITEMS.nitems_while{|x| x < 'c' },'< c')
    assert_equal(3,ITEMS.nitems_while{|x| x < 'd' },'< d')
    assert_equal(3,ITEMS.nitems_while{|x| x < 'e' },'< e')
  end


  def test_nitems_until
    assert_equal(0,ITEMS.nitems_until{|x| x == 'a' },'a')
    assert_equal(1,ITEMS.nitems_until{|x| x == 'b' },'b')
    assert_equal(2,ITEMS.nitems_until{|x| x == 'c' },'c')
    assert_equal(3,ITEMS.nitems_until{|x| x == 'd' },'d')
    assert_equal(3,ITEMS.nitems_until{|x| x == 'e' },'e')
  end

  
  def test_nitems_with_index
    assert_equal(0,ITEMS.nitems_with_index{|x,i| i < 0 },'i < 0')
    assert_equal(1,ITEMS.nitems_with_index{|x,i| i < 1 },'i < 1')
    assert_equal(2,ITEMS.nitems_with_index{|x,i| i < 2 },'i < 2')
    assert_equal(3,ITEMS.nitems_with_index{|x,i| i < 3 },'i < 3')
    assert_equal(3,ITEMS.nitems_with_index{|x,i| i < 4 },'i < 4')
  end


  ########################################################################
  #
  #  strings
  #
  ########################################################################


  def test_cat
    a=['anne','beth','cate']
    assert_equal("annebethcate",a.cat,"cat()")
    assert_equal("+anne+beth+cate",a.cat('+'),"cat('+')")
    assert_equal("+anne-+beth-+cate-",a.cat("+","-"),"cat('+','-')")
  end


end




