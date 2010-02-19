require 'test/unit'
require 'webget_ruby_ramp'
require 'set'

class EnumerableTest < Test::Unit::TestCase

  ITEMS = ['a','b','c']
  MAPTEST = [123,"456"] # to test typecasts-- one is numeric and one is string
  RGB = ["red","green","blue"]  # to test case changes


  ########################################################################
  #
  #  typecast
  #
  ########################################################################


  def test_to_h_with_unique_keys
    a=[[:a,:b],[:c,:d],[:e,:f]] 
    assert_equal({:a=>:b, :c=>:d, :e=>:f}, a.to_h)
  end

  def test_to_h_with_duplicate_keys
    a=[[:a,:b],[:a,:c],[:a,:d]] 
    assert_equal({:a=>[:b, :c, :d]}, a.to_h)
  end

  def test_index_by
    assert_equal({3=>"red",4=>"blue",5=>"green"},RGB.index_by{|x| x.size})
  end

  def test_hash_by
    assert_equal({3=>"RED",4=>"BLUE",5=>"GREEN"},RGB.hash_by{|x| [x.size,x.upcase]})
  end

    
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

    def to_a
     [self]
    end

  end


  A = Mock.new('a') 
  B = Mock.new('b') 
  C = Mock.new('c') 

  
  def test_map_id
    assert_equal(['a','b','c'],[A,B,C].map_id)
  end

  def test_map_to_a
    assert_equal([[123],["456"]],MAPTEST.to_set.map_to_a)
  end

  def test_map_to_f
    assert_equal([123.0,456.0],MAPTEST.map_to_f)
  end

  def test_map_to_i
    assert_equal([123,456],MAPTEST.map_to_i)
  end

  def test_map_to_s
    assert_equal(["123","456"],MAPTEST.map_to_s)
  end

  def test_map_to_sym
    assert_equal([:a,:b,:c],ITEMS.map_to_sym)
  end

  def test_map_with_index
    assert_equal(['a0','b1','c2'],ITEMS.map_with_index{|x,i| "#{x}#{i}"})
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
  #  bisect
  #
  ########################################################################

  def test_bisect
    assert_equal([[           ],['a','b','c']],ITEMS.bisect{|x| x < 'a' },'< a')
    assert_equal([['a'        ],[    'b','c']],ITEMS.bisect{|x| x < 'b' },'< b')
    assert_equal([['a','b'    ],[        'c']],ITEMS.bisect{|x| x < 'c' },'< c')
    assert_equal([['a','b','c'],[           ]],ITEMS.bisect{|x| x < 'd' },'< d')
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


  def test_join_0
    a=['a','b','c']
    assert_equal("abc",a.join,"join()")
  end

  def test_join_1
    a=['a','b','c']
    assert_equal("a+b+c",a.join('+'),"join('+')")
  end

  def test_join_2
    a=['a','b','c']
    assert_equal("+a-+b-+c-",a.join("+","-"),"join('+','-')")
  end


  ########################################################################
  #
  #  set math
  #
  ########################################################################

  def test_intersect_true
    assert_equal(true,['a','b'].intersect?(['b','c']))
  end

  def test_intersect_true_with_same
    assert_equal(true,['a','b'].intersect?(['a','b']))
  end

  def test_intersect_false
    assert_equal(false,['a','b'].intersect?(['c','d']))
  end

  def test_intersect_false_with_none
    assert_equal(false,['a','b','c'].intersect?([]))
  end

  CARTESIAN_PRODUCT_EXPECT=[["a", "d", "g"],
                            ["a", "d", "h"],
                            ["a", "d", "i"],
                            ["a", "e", "g"],
                            ["a", "e", "h"],
                            ["a", "e", "i"],
                            ["a", "f", "g"],
                            ["a", "f", "h"],
                            ["a", "f", "i"],
                            ["b", "d", "g"],
                            ["b", "d", "h"],
                            ["b", "d", "i"],
                            ["b", "e", "g"],
                            ["b", "e", "h"],
                            ["b", "e", "i"],
                            ["b", "f", "g"],
                            ["b", "f", "h"],
                            ["b", "f", "i"],
                            ["c", "d", "g"],
                            ["c", "d", "h"],
                            ["c", "d", "i"],
                            ["c", "e", "g"],
                            ["c", "e", "h"],
                            ["c", "e", "i"],
                            ["c", "f", "g"],
                            ["c", "f", "h"],
                            ["c", "f", "i"]]

  def test_cartesian_product_class_method
    a1=['a','b','c']
    a2=['d','e','f']
    a3=['g','h','i']
    actual=Enumerable.cartesian_product(a1,a2,a3)
    assert_equal(CARTESIAN_PRODUCT_EXPECT,actual,'class method')
  end

  def test_cartesian_product_instance_method
    a1=['a','b','c']
    a2=['d','e','f']
    a3=['g','h','i']
    actual=a1.cartesian_product(a2,a3)
    assert_equal(CARTESIAN_PRODUCT_EXPECT,actual,'instance method')
  end

  def test_power_set
    a=['a','b','c']
    expect=[[],['a'],['a','b'],['a','b','c'],['a','c'],['b'],['b','c'],['c']]
    actual=a.power_set.sort
    assert_equal(expect,actual)
  end

end




