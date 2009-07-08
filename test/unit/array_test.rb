require 'test/unit'
require 'ramp'

class ArrayTest < Test::Unit::TestCase

  def test_join
    a=['a','b','c']
    assert_equal('abc',a.join)
    assert_equal('a+b+c',a.join('+'))
    assert_equal('+a-+b-+c-',a.join('+','-'))
  end

  def test_size
    assert_equal(false,[].size?)
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
 end

 def test_choice
   a=[1,2,3,4]
   c=a.choice
   assert_equal(Fixnum,c.class)
   assert(a.include?(c))
 end

 def test_choices
   a=[1,2,3,4]
   c=a.choices(2)
   assert_equal(2,c.size)
   assert(a.include?(c[0]))
   assert(a.include?(c[1]))
   c=a.choices(3)
   assert_equal(3,c.size)
   assert(a.include?(c[0]))
   assert(a.include?(c[1]))
   assert(a.include?(c[2]))
 end

 def test_hash
   foo=[:a,:b,:c]
   goo=[:x,:y,:z]
   assert_equal({:a=>:x, :b=>:y, :c=>:z},foo.hash(goo))
 end

 def test_slices
  a=[1,2,3,4,5,6,7,8]
  assert_equal([[1,2],[3,4],[5,6],[7,8]],a.slices(2))
  assert_equal([[1,2,3,4],[5,6,7,8]], a.slices(4))
  assert_equal([[1,2,3],[4,5,6],[7,8]],a.slices(3))
  assert_equal([[1,2,3,4,5],[6,7,8]],a.slices(5))
 end

 def test_divvy_evenly_divisible
   assert_equal([[1,2,3],[4,5]],[1,2,3,4,5].divvy(2),'division with equal slices')
   assert_equal([[1,2,3],[4,5,6],[7]],[1,2,3,4,5,6,7].divvy(3),'division with remainer slice')
   assert_equal([[1,2],[3,4],[5,6]],[1,2,3,4,5,6].divvy(4),'division with small numbers')
 end

 def test_union
   a=[[2,3,4],[4,5,6],[6,7,8]]
   assert_equal([2,3,4,5,6,7,8],a.union)
 end

 def test_intersect
   a=[[2,3,4],[4,3,5],[3,4,7]]
   assert_equal([3,4],a.intersect)
 end

  def test_to_csv
    a=[["a", "b"], ["c", "d"], ["e", "f"]]
    assert_equal("a,b\nc,d\ne,f\n",a.to_csv)
  end

end


