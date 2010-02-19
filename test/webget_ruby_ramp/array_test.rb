require 'test/unit'
require 'csv'
require 'webget_ruby_ramp'

class ArrayTest < Test::Unit::TestCase

  A=['a','b','c','d']
  B=['w','x','y','z']
  SLICEABLE=['a','b','c','d','e','f','g','h']

  def test_join_with_blank
    assert_equal('abcd', A.join(''))
  end
  
  def test_join_with_infix
    assert_equal('a*b*c*d', A.join('*'))
  end

  def test_join_with_infix_and_prefix_and_suffix
    assert_equal('[a]*[b]*[c]*[d]', A.join('*','[',']'))
  end
  
  def test_join_with_prefix_and_suffix
    assert_equal('[a][b][c][d]', A.join('[',']'))
  end

  def test_join_with_no_ops
    assert_equal('abcd',A.join)
  end

  def test_join_with_too_many_ops
    assert_raise(ArgumentError){ A.join('','','','') }
  end

  def test_size_with_one_item
    assert_equal(true,[1].size?)
  end

  def test_size_with_two_items
    assert_equal(true,[1,2].size?)
  end

  def test_size_with_empty
    assert_equal(false,[].size?)
  end

  def test_size_with_nil
    assert_equal(true,[nil].size?)
  end

  def test_size_with_one_empty
    assert_equal(true,[[]].size?)
  end
  
 def test_rotate
   a=A.dup
   a.rotate!
   assert_equal(['b','c','d','a'],a)
   a.rotate!
   assert_equal(['c','d','a','b'],a)
   a.rotate!
   assert_equal(['d','a','b','c'],a)
   a.rotate!
   assert_equal(['a','b','c','d'],a)
 end

 def test_rotate_with_empty
   a=[]
   a.rotate!
   assert_equal([],a)
 end

 def test_choice
   5.times {
     c=A.choice
     assert_equal(String,c.class)
     assert(A.include?(c))
   }
 end

 def test_choices
   5.times {
     c=A.choices(2)
     assert_equal(2,c.size)
     assert(A.include?(c[0]))
     assert(A.include?(c[1]))
     c=A.choices(3)
     assert_equal(3,c.size)
     assert(A.include?(c[0]))
     assert(A.include?(c[1]))
     assert(A.include?(c[2]))
   }
 end

 def test_onto
   assert_equal({'a'=>'w', 'b'=>'x', 'c'=>'y', 'd'=>'z'},A.onto(B))
 end

 def test_onto_with_empty
   assert_raise(ArgumentError){ A.onto([]) }
 end

 def test_slices_with_balanced_results
   assert_equal([['a','b'],['c','d'],['e','f'],['g','h']], SLICEABLE.slices(2))
   assert_equal([['a','b','c','d'],['e','f','g','h']], SLICEABLE.slices(4))
 end

 def test_slices_with_unbalanced_results
   assert_equal([['a','b','c'],['d','e','f'],['g','h']], SLICEABLE.slices(3))
   assert_equal([['a','b','c','d','e'],['f','g','h']], SLICEABLE.slices(5))
 end

 def test_slices_with_empty
   assert_equal([],[].slices(1))
 end
 
 def test_slices_with_negative_count
   assert_raise(ArgumentError){ [].slices(-1) }
 end

 def test_slices_with_non_integer_count
   assert_raise(ArgumentError){ [].slices(0.123) }
 end

 def test_slices_with_non_numeric_count
   assert_raise(ArgumentError){ [].slices("") }
 end

 def test_divvy_with_one_slice
   assert_equal([[1,2,3,4,5,6]],[1,2,3,4,5,6].divvy(1))
 end

 def test_divvy_with_equal_slices
   assert_equal([[1,2,3],[4,5]],[1,2,3,4,5].divvy(2))
 end

 def test_divvy_with_remainer_slice
   assert_equal([[1,2,3],[4,5,6],[7]],[1,2,3,4,5,6,7].divvy(3))
 end

 def test_divvy_with_small_number
   assert_equal([[1,2],[3,4],[5,6]],[1,2,3,4,5,6].divvy(4))
 end

 def test_divvy_with_negative_count
   assert_raise(ArgumentError){ [].divvy(-1) }
 end

 def test_divvy_with_non_integer_count
   assert_raise(ArgumentError){ [].divvy(0.123) }
 end

 def test_divvy_with_non_numeric_count
   assert_raise(ArgumentError){ [].divvy("") }
 end

 def test_union
   a=[[1,2,3,4],[2,3,4,5],[3,4,5,6]]
   assert_equal([1,2,3,4,5,6],a.union)
 end

 def test_union_with_empty
   assert_equal([],[].union)
 end

 def test_intersect
   a=[[1,2,3,4],[2,3,4,5],[3,4,5,6]]
   assert_equal([3,4],a.intersect)
 end

 def test_intersect_with_empty
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
  end

  def test_shifted_with_negative_count
    assert_raise(ArgumentError){ [].shifted(-1) }
  end

  def test_shifted_with_non_integer_count
    assert_raise(ArgumentError){ [].shifted(0.123) }
  end

  def test_shifted_with_non_numeric_count
    assert_raise(ArgumentError){ [].shifted("") }
  end

  # alias: test_cdr must be idential to test_shifted
  def test_cdr
    a=['a','b','c']
    assert_equal([    'b','c'],a.cdr)
    assert_equal(['a','b','c'],a.cdr(0))
    assert_equal([    'b','c'],a.cdr(1))
    assert_equal([        'c'],a.cdr(2))
    assert_equal([           ],a.cdr(3))
    assert_equal(nil          ,a.cdr(4))
  end

  # alias: test_cdr must be idential to test_shifted
  def test_cdr_with_negative_count    
    assert_raise(ArgumentError){ [].cdr(-1) }
  end

  # alias: test_cdr must be idential to test_shifted
  def test_cdr_with_non_integer_count
    assert_raise(ArgumentError){ [].cdr(0.123) }
  end

  # alias: test_cdr must be idential to test_shifted
  def test_cdr_with_non_numeric_count
    assert_raise(ArgumentError){ [].cdr("") }
  end

  # alias: test_rest must be idential to test_shifted
  def test_rest
    a=['a','b','c']
    assert_equal([    'b','c'],a.rest)
    assert_equal(['a','b','c'],a.rest(0))
    assert_equal([    'b','c'],a.rest(1))
    assert_equal([        'c'],a.rest(2))
    assert_equal([           ],a.rest(3))
    assert_equal(nil          ,a.rest(4))
  end

  # alias: test_rest must be idential to test_shifted
  def test_rest_with_negative_count
    assert_raise(ArgumentError){ [].rest(-1) }
  end

  # alias: test_rest must be idential to test_shifted
  def test_rest_with_non_integer_count
    assert_raise(ArgumentError){ [].rest(0.123) }
  end

  # alias: test_rest must be idential to test_shifted
  def test_rest_with_non_numeric_count
    assert_raise(ArgumentError){ [].rest("") }
  end

  def test_shifted_bang
    a=['a','b','c']; a.shifted!;    assert_equal([    'b','c'],a)
    a=['a','b','c']; a.shifted!(0); assert_equal(['a','b','c'],a)
    a=['a','b','c']; a.shifted!(1); assert_equal([    'b','c'],a)
    a=['a','b','c']; a.shifted!(2); assert_equal([        'c'],a)
    a=['a','b','c']; a.shifted!(3); assert_equal([           ],a)
    a=['a','b','c']; a.shifted!(4); assert_equal([           ],a)
  end

  def test_shifted_bang_with_negative_count    
    assert_raise(ArgumentError){ [].shifted!(-1) }
  end

  def test_shifted_bang_with_non_integer_count    
    assert_raise(ArgumentError){ [].shifted!(0.123) }
  end

  def test_shifted_bang_with_non_numeric_count    
    assert_raise(ArgumentError){ [].shifted!("") }
  end

  # alias: test_cdr_bang must be identical to test_shifted_bang
  def test_cdr_bang
    a=['a','b','c']; a.cdr!;    assert_equal([    'b','c'],a)
    a=['a','b','c']; a.cdr!(0); assert_equal(['a','b','c'],a)
    a=['a','b','c']; a.cdr!(1); assert_equal([    'b','c'],a)
    a=['a','b','c']; a.cdr!(2); assert_equal([        'c'],a)
    a=['a','b','c']; a.cdr!(3); assert_equal([           ],a)
    a=['a','b','c']; a.cdr!(4); assert_equal([           ],a)
  end

  # alias: test_cdr_bang must be identical to test_shifted_bang
  def test_cdr_bang_with_negative_count
    assert_raise(ArgumentError){ [].cdr!(-1) }
  end

  # alias: test_cdr_bang must be identical to test_shifted_bang
  def test_cdr_bang_with_non_integer_count
    assert_raise(ArgumentError){ [].cdr!(0.123) }
  end

  # alias: test_cdr_bang must be identical to test_shifted_bang
  def test_cdr_bang_with_non_numeric_count
    assert_raise(ArgumentError){ [].cdr!("") }
  end
  
  # alias: test_rest_bang must be identical to test_shifted_bang
  def test_rest_bang
    a=['a','b','c']; a.rest!;    assert_equal([    'b','c'],a)
    a=['a','b','c']; a.rest!(0); assert_equal(['a','b','c'],a)
    a=['a','b','c']; a.rest!(1); assert_equal([    'b','c'],a)
    a=['a','b','c']; a.rest!(2); assert_equal([        'c'],a)
    a=['a','b','c']; a.rest!(3); assert_equal([           ],a)
    a=['a','b','c']; a.rest!(4); assert_equal([           ],a)
  end
    
  # alias: test_rest_bang must be identical to test_shifted_bang
  def test_rest_bang_with_negative_count
    assert_raise(ArgumentError){ [].rest!(-1) }
  end

  # alias: test_rest_bang must be identical to test_shifted_bang
  def test_rest_bang_with_non_integer_count
    assert_raise(ArgumentError){ [].rest!(0.123) }
  end

  # alias: test_rest_bang must be identical to test_shifted_bang
  def test_rest_bang_with_non_numeric_count
    assert_raise(ArgumentError){ [].rest!("") }
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
    assert_equal("a,b,c,d\n",A.to_csv)
  end

  def test_to_csv_with_empty
    assert_equal("",[].to_csv)    
  end

  def test_to_csv_multi_dimensional
    a=[["a","b","c"], ["d","e","f"],["g","h","i"]]
    assert_equal("a,b,c\nd,e,f\ng,h,i\n",a.to_csv)
  end

  def test_to_tsv
    a=[["a", "b"], ["c", "d"], ["e", "f"]]
    assert_equal("a\tb\nc\td\ne\tf\n",a.to_tsv)
  end

  def test_to_tsv_with_empty
    assert_equal("",[].to_tsv)    
  end

  # alias: test_to_tdf must be identical to test_to_tsv
  def test_to_tdf
    a=[["a", "b"], ["c", "d"], ["e", "f"]]
    assert_equal("a\tb\nc\td\ne\tf\n",a.to_tdf)
  end

  # alias: test_to_tdf must be identical to test_to_tsv
  def test_to_tdf_with_empty
    assert_equal("",[].to_tdf)    
  end

end


