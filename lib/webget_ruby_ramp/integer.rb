# -*- encoding: utf-8 -*-

# Integer extensions

class Integer

  # Syntactic sugar to yield n times to a block.
  #
  # Comparison to Integer#times: 
  # Integer#maps is similar to Integer#times except that the output from each
  # call to the block is captured in an array element and that array is
  # returned to the calling code.
  #
  # @return an array of any results
  #
  # @example Generate an array of three random numbers
  #   3.maps{rand}
  #   => [0.0248131784304143, 0.814666170190905, 0.15812816258206]
  #
  
  def maps
    return (0...self).map{|item| yield item}
  end


end
