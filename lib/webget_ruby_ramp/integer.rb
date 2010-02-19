# -*- encoding: utf-8 -*-

# Integer extensions

class Integer

  # Syntactic sugar to yield n times to a block.
  #
  # Return an array of any results.
  #
  # ==Example
  #   3.maps{rand} => [0.0248131784304143, 0.814666170190905, 0.15812816258206]
  #
  # ==Parallel to Integer#times
  #
  # Integer#maps is similar to Integer#times except that the output from each
  # call to the block is captured in an array element and that array is
  # returned to the calling code.
  
  def maps
    (0...self).map{|item| yield item}
  end


  # Return true if the number is even
  #
  # ==Example
  #   2.even? => true
  #   3.even? => false

  def even?
    self % 2 == 0
  end


  # Return true if the number is odd
  #
  # ==Example
  #   2.odd? => false
  #   3.odd? => true

  def odd?
    self %2 == 1
  end

end
