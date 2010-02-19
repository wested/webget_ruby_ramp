require 'test/unit'
require 'webget_ruby_ramp'

class NumericTest < Test::Unit::TestCase


  def test_if_with_true
    assert_equal(5,5.if(true))
  end


  def test_if_with_false
    assert_equal(0,5.if(false))
  end


  def test_unless_with_true
    assert_equal(0,5.unless(true))
  end


  def test_unless_with_false
    assert_equal(5,5.unless(false))
  end

  
  def test_peta
    assert_equal(1,1000000000000000.peta)
  end


  def test_tera
    assert_equal(1,1000000000000.tera)
  end


  def test_giga
    assert_equal(1,1000000000.giga)
  end


  def test_mega
    assert_equal(1,1000000.mega)
  end


  def test_kilo
    assert_equal(1,1000.kilo)
  end


  def test_hecto
    assert_equal(1,100.hecto)
  end


  def test_deka
    assert_equal(1,10.deka)
  end


  def test_deci
    assert_equal(1,0.1.deci)
  end


  def test_centi
    assert_equal(1,0.01.centi)
  end


  def test_milli
    assert_equal(1,0.001.milli)
  end


  def test_micro
    assert_equal(1,0.000001.micro)
  end


  def test_nano
    assert_equal(1,0.000000001.nano)
  end


end

