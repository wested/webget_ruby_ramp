class Integer

  # Syntactic sugar to yield n times to a block.
  # Return an array of any results.
  #
  # Examples
  #   3.maps{foo} => calls method foo 3 times, and returns an array of results
  #   3.maps{rand} => [0.0248131784304143, 0.814666170190905, 0.15812816258206]
  #
  # Parallel to Integer#times
  # That is, maps is similar to Integer#times except that the output from each
  # call to the block is captured in an array element and that array is
  # returned to the calling code.
  
  def maps
    (0...self).map{|i| yield i}
  end

end