require 'test/unit'
require 'csv'
require 'webget_ruby_ramp'

class ArrayTest < Test::Unit::TestCase

  def test_join
    a=['a','b','c']
    assert_equal('abc',a.join)
    assert_equal('abc',a.join(''))
    assert_equal('a*b*c',a.join('*'))
    assert_equal('[a]*[b]*[c]',a.join('*','[',']'))
    assert_equal('[a][b][c]',a.join('[',']'))
    assert_raise(ArgumentError){ a.join('','','','') }
  end

  def test_size
    assert_equal(false,[].size?)
    assert_equal(true,[nil].size?)
    assert_equal(true,[1].size?)
    assert_equal(true,[1,2].size?)
    assert_equal(true,[[]].size?)
  end
  
 def test_rotate
   a=[1,2,3,4]
   a.rotate!
   assert_equal([2,3,4,1],a)
   a.rotate!
   assert_equal([3,4,1,2],a)
   a.rotate!
   a=[]
   a.rotate!
   assert_equal([],a)
 end

 def test_choice
   a=[1,2,3,4]
   5.times {
     c=a.choice
     assert_equal(Fixnum,c.class)
     assert(a.include?(c))
   }
 end

 def test_choices
   a=[1,2,3,4]
   5.times {
     c=a.choices(2)
     assert_equal(2,c.size)
     assert(a.include?(c[0]))
     assert(a.include?(c[1]))
     c=a.choices(3)
     assert_equal(3,c.size)
     assert(a.include?(c[0]))
     assert(a.include?(c[1]))
     assert(a.include?(c[2]))
   }
 end

 def test_onto
   foo=[:a,:b,:c]
   goo=[:x,:y,:z]
   assert_equal({:a=>:x, :b=>:y, :c=>:z},foo.onto(goo))
   assert_raise(ArgumentError){ foo.onto([]) }
 end

 def test_slices
   a=[1,2,3,4,5,6,7,8]
   assert_equal([[1,2],[3,4],[5,6],[7,8]],a.slices(2))
   assert_equal([[1,2,3,4],[5,6,7,8]], a.slices(4))
   assert_equal([[1,2,3],[4,5,6],[7,8]],a.slices(3))
   assert_equal([[1,2,3,4,5],[6,7,8]],a.slices(5))
   assert_equal([],[].slices(1))
   assert_raise(ArgumentError){ a.slices(-1) }
   assert_raise(ArgumentError){ a.slices("") }
   assert_raise(ArgumentError){ a.slices(0.123) }
 end

 def test_divvy
   assert_equal([[1,2,3,4,5,6]],[1,2,3,4,5,6].divvy(1),'division into one slice')
   assert_equal([[1,2,3],[4,5]],[1,2,3,4,5].divvy(2),'division with equal slices')
   assert_equal([[1,2,3],[4,5,6],[7]],[1,2,3,4,5,6,7].divvy(3),'division with remainer slice')
   assert_equal([[1,2],[3,4],[5,6]],[1,2,3,4,5,6].divvy(4),'division with small numbers')
   assert_raise(ArgumentError){ [].divvy(-1) }
   assert_raise(ArgumentError){ [].divvy("") }
   assert_raise(ArgumentError){ [].divvy(0.123) }
 end

 def test_union
   a=[[1,2,3,4],[2,3,4,5],[3,4,5,6]]
   assert_equal([1,2,3,4,5,6],a.union)
   assert_equal([],[].union)
 end

 def test_intersect
   a=[[1,2,3,4],[2,3,4,5],[3,4,5,6]]
   assert_equal([3,4],a.intersect)
   assert_equal([],[].intersect)
 end

  def test_shifted
    a=['a','b','c']
    assert_equal([    'b','c'],a.shifted)
    assert_equal(['a','b','c'],a.shifted(0))
    assert_equal([    'b','c'],a.shifted(1))
    assert_equal([        'c'],a.shifted(2))
    assert_equal([           ],a.shifted(3))
    assert_equal(nil          ,a.shifted(4))
    assert_raise(ArgumentError){ a.shifted(-1) }
    assert_raise(ArgumentError){ a.shifted("") }
    assert_raise(ArgumentError){ a.shifted(0.123) }
  end

  # test_cdr must be idential to test_shifted
  # because cdr is an alias for shifted
  def test_cdr
    a=['a','b','c']
    assert_equal([    'b','c'],a.cdr)
    assert_equal(['a','b','c'],a.cdr(0))
    assert_equal([    'b','c'],a.cdr(1))
    assert_equal([        'c'],a.cdr(2))
    assert_equal([           ],a.cdr(3))
    assert_equal(nil          ,a.cdr(4))
    assert_raise(ArgumentError){ a.cdr(-1) }
    assert_raise(ArgumentError){ a.cdr("") }
    assert_raise(ArgumentError){ a.cdr(0.123) }
  end

  # test_rest must be idential to test_shifted
  # because rest is an alias for shifted
  def test_rest
    a=['a','b','c']
    assert_equal([    'b','c'],a.rest)
    assert_equal(['a','b','c'],a.rest(0))
    assert_equal([    'b','c'],a.rest(1))
    assert_equal([        'c'],a.rest(2))
    assert_equal([           ],a.rest(3))
    assert_equal(nil          ,a.rest(4))
    assert_raise(ArgumentError){ a.rest(-1) }
    assert_raise(ArgumentError){ a.rest("") }
    assert_raise(ArgumentError){ a.rest(0.123) }
  end

  def test_shifted_bang
    a=['a','b','c']; a.shifted!;    assert_equal([    'b','c'],a)
    a=['a','b','c']; a.shifted!(0); assert_equal(['a','b','c'],a)
    a=['a','b','c']; a.shifted!(1); assert_equal([    'b','c'],a)
    a=['a','b','c']; a.shifted!(2); assert_equal([        'c'],a)
    a=['a','b','c']; a.shifted!(3); assert_equal([           ],a)
    a=['a','b','c']; a.shifted!(4); assert_equal([           ],a)
    a=[]
    assert_raise(ArgumentError){ a.shifted!(-1) }
    assert_raise(ArgumentError){ a.shifted!("") }
    assert_raise(ArgumentError){ a.shifted!(0.123) }
  end

  # alias: test_cdr_bang must be identical to test_shifted_bang
  def test_cdr_bang
    a=['a','b','c']; a.cdr!;    assert_equal([    'b','c'],a)
    a=['a','b','c']; a.cdr!(0); assert_equal(['a','b','c'],a)
    a=['a','b','c']; a.cdr!(1); assert_equal([    'b','c'],a)
    a=['a','b','c']; a.cdr!(2); assert_equal([        'c'],a)
    a=['a','b','c']; a.cdr!(3); assert_equal([           ],a)
    a=['a','b','c']; a.cdr!(4); assert_equal([           ],a)
    a=[]
    assert_raise(ArgumentError){ a.cdr!(-1) }
    assert_raise(ArgumentError){ a.cdr!("") }
    assert_raise(ArgumentError){ a.cdr!(0.123) }
  end

  # alias: test_rest_band must be identical to test_shifted_bang
  def test_rest_bang
    a=['a','b','c']; a.rest!;    assert_equal([    'b','c'],a)
    a=['a','b','c']; a.rest!(0); assert_equal(['a','b','c'],a)
    a=['a','b','c']; a.rest!(1); assert_equal([    'b','c'],a)
    a=['a','b','c']; a.rest!(2); assert_equal([        'c'],a)
    a=['a','b','c']; a.rest!(3); assert_equal([           ],a)
    a=['a','b','c']; a.rest!(4); assert_equal([           ],a)
    a=[]
    assert_raise(ArgumentError){ a.rest!(-1) }
    assert_raise(ArgumentError){ a.rest!("") }
    assert_raise(ArgumentError){ a.rest!(0.123) }
  end

  def test_car
    a=['a','b','c']
    assert_equal('a',a.car)
  end

  def test_shuffle
    a=[1,2,3,4]
    5.times {
      b=a.shuffle
      assert_equal(a.size,b.size)
      a.each{|item| assert(b.include?(item)) }
    }
  end

  def test_shuffle_bang
    a=[1,2,3,4]
    b=a.dup
    5.times {
      b.shuffle!
      assert_equal(a.size,b.size)
      a.each{|item| assert(b.include?(item)) }
    }
  end

  def test_to_csv_one_dimensional
    a=["a","b","c"]
    assert_equal("a,b,c\n",a.to_csv)
    assert_equal("",[].to_csv)    
  end

  def test_to_csv_multi_dimensional
    a=[["a","b","c"], ["d","e","f"],["g","h","i"]]
    assert_equal("a,b,c\nd,e,f\ng,h,i\n",a.to_csv)
  end

  def test_to_tsv
    a=[["a", "b"], ["c", "d"], ["e", "f"]]
    assert_equal("a\tb\nc\td\ne\tf\n",a.to_tsv)
    assert_equal("",[].to_tsv)    
  end

  # alias: test_to_tdf must be identical to test_to_tsv
  def test_to_tdf
    a=[["a", "b"], ["c", "d"], ["e", "f"]]
    assert_equal("a\tb\nc\td\ne\tf\n",a.to_tdf)
    assert_equal("",[].to_tdf)    
  end

end


