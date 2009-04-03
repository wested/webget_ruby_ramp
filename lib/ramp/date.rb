require 'date'

class Date


  # Return date in a sql format: YYYY-MM-DD
  #
  # Example:
  #  d=Date.today
  #  d.to_sql => "2007-12-31"

  def to_sql
    return to_time.strftime("%Y-%m-%d")
  end


  # Return true if the date is a weekday (Mon/Tue/Wed/Thu/Fri)

  def weekday?
    wday>0 and wday<6
  end


  # Return true if the date is a weekend (Sat/Sun)

  def weekend?
    wday==0 or wday==6
  end


  # Return a random date between min & max

  def self.between(min,max)
    min+rand(max-min)
  end


  # Return the age in years for a given date.
  #
  # ==Example
  #
  #   birthdate=Date.new(1980,10,31)
  #   birthdate.age_years => 28 (where 28 is the correct age for today)
  #
  # ==Example of custom dates
  #
  #   birthdate=Date.new(1980,10,31)
  #
  #   valentines = Date.new(2008,02,14)
  #   birthdate.age_years(valentines) => 27  # before the birthday
  #
  #   halloween = Date.new(2008,10,31)
  #   birthdate.age_years(halloween) => 28   # on the birthday
  #
  #   new_years_eve = Date.new(2008,12,31)
  #   birthdate.age_years(new_years_eve) => 28  # after the birthday

  def age_years(compare_date=Date.today)
    age=compare_date.year-year
    age-=1 if compare_date.month < month or (compare_date.month==month and compare_date.day < day)
    age
  end


  # Return the age in days for a given date.

  def age_days(compare_to_date=Date.today)
    (compare_to_date-self).to_i
  end


end