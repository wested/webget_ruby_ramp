require 'test/unit'
require 'webget_ruby_ramp'

class DateTest < Test::Unit::TestCase


  def test_weekday
    # Start on Monday, January 1, 2007
    assert( Date.new(2007,1,1).weekday?) 
    assert( Date.new(2007,1,2).weekday?)
    assert( Date.new(2007,1,3).weekday?)
    assert( Date.new(2007,1,4).weekday?)
    assert( Date.new(2007,1,5).weekday?)
    assert(!Date.new(2007,1,6).weekday?)
    assert(!Date.new(2007,1,7).weekday?)
    assert( Date.new(2007,1,8).weekday?)
  end


  def test_weekend
    # Start on Monday, January 1, 2007
    assert(!Date.new(2007,1,1).weekend?) 
    assert(!Date.new(2007,1,2).weekend?) 
    assert(!Date.new(2007,1,3).weekend?) 
    assert(!Date.new(2007,1,4).weekend?) 
    assert(!Date.new(2007,1,5).weekend?) 
    assert( Date.new(2007,1,6).weekend?) 
    assert( Date.new(2007,1,7).weekend?) 
    assert(!Date.new(2007,1,8).weekend?) 
  end


  def test_to_sql_with_non_zero_month_and_mday
    assert_equal('2007-12-31',Date.new(2007,12,31).to_sql)
  end


  def test_to_sql_with_zero_month_and_mday
    assert_equal('2007-01-02',Date.new(2007,1,2).to_sql)
  end


  # for test_age_years and test_age_days
  BIRTHDATE     = Date.new(1980,10,31)
  VALENTINES    = Date.new(2008,02,14)
  HALLOWEEN     = Date.new(2008,10,31)
  NEW_YEARS_EVE = Date.new(2008,12,31)


  def test_age_years
    assert_equal(27,BIRTHDATE.age_years(VALENTINES),    '< birthday')
    assert_equal(28,BIRTHDATE.age_years(HALLOWEEN),     '= birthday')
    assert_equal(28,BIRTHDATE.age_years(NEW_YEARS_EVE), '> birthday')
  end

  def test_age_years_with_non_date
    assert_raise(ArgumentError){ BIRTHDATE.age_years('') }
  end

  def test_age_days
    assert_equal( 9967,BIRTHDATE.age_days(VALENTINES),     '< birthday')
    assert_equal(10227,BIRTHDATE.age_days(HALLOWEEN),      '= birthday')
    assert_equal(10288,BIRTHDATE.age_days(NEW_YEARS_EVE),  '> birthday')
  end

  def test_age_days_with_non_date
    assert_raise(ArgumentError){ BIRTHDATE.age_days('') }
  end


end

