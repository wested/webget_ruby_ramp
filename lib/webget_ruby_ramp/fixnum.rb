# -*- encoding: utf-8 -*-

# Fixnum extensions

class Fixnum


  # @return true if the number is even
  #
  # @example
  #   2.even? => true
  #   3.even? => false
  #
  # From http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/4516

  def even?
    return self & 1 == 0
  end


  # @return true if the number is odd
  #
  # @example
  #   2.odd? => false
  #   3.odd? => true
  #
  # From http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/4516
  
  def odd?
    return self & 1 != 0
  end


end
