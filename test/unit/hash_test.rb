require 'test/unit'
require 'ramp'

class HashTest < Test::Unit::TestCase


  def test_size
    h = {'a'=>'b'}
    assert(h.size?)
    h = {}
    assert(!h.size?)
  end


  def test_each_value
    h = { "a" => 100, "b" => 200 }
    h.each_value! {|value| value+5 }
    assert_equal(105,h['a'])
    assert_equal(205,h['b'])
  end


  def setup_rollable
    @h=Hash.new
    @h['a']=Hash.new
    @h['b']=Hash.new
    @h['c']=Hash.new
    @h['a']['x']='m'
    @h['a']['y']='n'
    @h['a']['z']='o'
    @h['b']['x']='p'
    @h['b']['y']='q'
    @h['b']['z']='r'
    @h['c']['x']='s'
    @h['c']['y']='t'
    @h['c']['z']='u'
  end  


  def test_rolldown
    setup_rollable
    r=@h.rolldown
    assert_equal(['x','y','z'], r.keys.sort)
    assert_equal(['m','p','s'], r['x'].sort)
    assert_equal(['n','q','t'], r['y'].sort)
    assert_equal(['o','r','u'], r['z'].sort)
  end


  def test_rolldown_with_block
    setup_rollable
    r = @h.rolldown{|items| items.sort.inject{|sum,x| sum+=x}}
    assert_equal(['x','y','z'], r.keys.sort)
    assert_equal('mps', r['x'])
    assert_equal('nqt', r['y'])
    assert_equal('oru', r['z'])
  end


  def test_rollup
    setup_rollable
    r=@h.rollup
    assert_equal(['a','b','c'], r.keys.sort)
    assert_equal(['m','n','o'], r['a'].sort)
    assert_equal(['p','q','r'], r['b'].sort)
    assert_equal(['s','t','u'], r['c'].sort)
  end


  def test_rollup_with_block
    r = @h.rollup{|items| items.sort.inject{|sum,x| sum+=x}}
    assert_equal(['a','b','c'], r.keys.sort)
    assert_equal('mno', r['a'])
    assert_equal('pqr', r['b'])
    assert_equal('stu', r['c'])
  end


end




