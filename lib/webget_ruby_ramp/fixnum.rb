# -*- encoding: utf-8 -*-

# Fixnum extensions

class Fixnum


  # Return true if the number is even
  #
  # ==Example
  #   2.even? => true
  #   3.even? => false
  #
  # From http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/4516

  def even?
    return self & 1 == 0
  end


  # Return true if the number is odd
  #
  # ==Example
  #   2.odd? => false
  #   3.odd? => true
  #
  # n.b. we test to see if this method already exists,
  # because this method is defined in Ruby 1.8.7 onward.
  #
  # From http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/4516
  
  def odd?
    return self & 1 != 0
  end


end
