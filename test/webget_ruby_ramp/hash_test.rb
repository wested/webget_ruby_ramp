require 'test/unit'
require 'webget_ruby_ramp'

class HashTest < Test::Unit::TestCase


  def test_size_true
    h = {'a'=>'b'}
    assert(h.size?)
  end


  def test_size_false
    h = {}
    assert(!h.size?)
  end


  def test_each_sort
    out = []
    h = {'c' => 'z', 'b' => 'y', 'a' => 'x'}
    h.each_sort{|key,val| out << key.upcase; out << val.upcase}
    assert_equal(['A','X','B','Y','C','Z'], out)
  end


  def test_each_sort_with_empty
    out = []
    h = {}
    h.each_sort{|key,val| out << key.upcase; out << val.upcase}
    assert_equal([], out)
  end


  def test_each_key_bang
    actual = { "a" => "b", "c" => "d" }
    expect = { "A" => "b", "C" => "d" }
    actual.each_key! {|key| key.upcase }
    assert_equal(expect,actual)
  end


  def test_each_key_bang_with_empty
    actual = {}
    expect = {}
    actual.each_key! {|key| key.upcase }
    assert_equal(expect,actual)
  end


  def test_each_pair_bang
    actual = { "a" => "b", "c" => "d" }
    expect = { "A" => "B", "C" => "D" }
    actual.each_pair! {|key,value| [key.upcase, value.upcase] }
    assert_equal(expect,actual)
  end


  def test_each_pair_bang_with_empty
    actual = {}
    expect = {}
    actual.each_pair! {|key,value| [key.upcase, value.upcase] }
    assert_equal(expect,actual)
  end


  def test_each_value_bang
    actual = { "a" => "b", "c" => "d" }
    expect = { "a" => "B", "c" => "D" }
    actual.each_value! {|value| value.upcase }
    assert_equal(expect,actual)
  end


  def test_each_value_bang_with_empty
    actual = {}
    expect = {}
    actual.each_value! {|value| value.upcase }
    assert_equal(expect,actual)
  end


  def test_map_pair
    h = {"a"=>"b", "c"=>"d", "e"=>"f" }
    expect=["ab","cd","ef"]  
    actual=h.map_pair{|key,value| key+value }.sort
    assert_equal(expect,actual,h.inspect)
  end


  def test_map_pair_with_empty
    h = {}
    expect=[]
    actual=h.map_pair{|key,value| key+value }.sort
    assert_equal(expect,actual,h.inspect)
  end
   

  def test_to_yaml_sort
    h = {"a"=>"b", "c"=>"d", "e"=>"f" }
    assert_equal("--- \na: b\nc: d\ne: f\n", h.to_yaml_sort)
  end

    
  def pivotable
    h=Hash.new
    h['a']=Hash.new
    h['b']=Hash.new
    h['c']=Hash.new
    h['a']['x']='m'
    h['a']['y']='n'
    h['a']['z']='o'
    h['b']['x']='p'
    h['b']['y']='q'
    h['b']['z']='r'
    h['c']['x']='s'
    h['c']['y']='t'
    h['c']['z']='u'
    return h
  end  


  def test_pivot_vals
    p=pivotable.pivot(:vals)
    assert_equal(['x','y','z'], p.keys.sort)
    assert_equal(['m','p','s'], p['x'].sort)
    assert_equal(['n','q','t'], p['y'].sort)
    assert_equal(['o','r','u'], p['z'].sort)
  end


  def test_pivot_vals_with_block
    p=pivotable.pivot(:vals){|items| items.sort.inject{|sum,x| sum+=x}}
    assert_equal(['x','y','z'], p.keys.sort)
    assert_equal('mps', p['x'])
    assert_equal('nqt', p['y'])
    assert_equal('oru', p['z'])
  end


  def test_pivot_keys
    p=pivotable.pivot(:keys)
    assert_equal(['a','b','c'], p.keys.sort)
    assert_equal(['m','n','o'], p['a'].sort)
    assert_equal(['p','q','r'], p['b'].sort)
    assert_equal(['s','t','u'], p['c'].sort)
  end


  def test_pivot_keys_with_block
    p=pivotable.pivot(:keys){|items| items.sort.inject{|sum,x| sum+=x}}
    assert_equal(['a','b','c'], p.keys.sort)
    assert_equal('mno', p['a'])
    assert_equal('pqr', p['b'])
    assert_equal('stu', p['c'])
  end


  def test_pivot_direction_up_with_true
    Hash.publicize_methods do
      assert({}.pivot_direction_up?('key'))
      assert({}.pivot_direction_up?('keys'))
      assert({}.pivot_direction_up?('up'))
      assert({}.pivot_direction_up?('left'))
      assert({}.pivot_direction_up?('out'))
    end
  end

  def test_pivot_direction_up_with_false
    Hash.publicize_methods do
      assert(!{}.pivot_direction_up?('val'))
      assert(!{}.pivot_direction_up?('vals'))
      assert(!{}.pivot_direction_up?('down'))
      assert(!{}.pivot_direction_up?('right'))
      assert(!{}.pivot_direction_up?('in'))
    end
  end

  def test_pivot_direction_up_with_invalid
    Hash.publicize_methods do
      assert_raise(ArgumentError){ {}.pivot_direction_up?('nonsense') }
    end
  end


end




