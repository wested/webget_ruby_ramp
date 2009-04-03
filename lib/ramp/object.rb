class Object

  # Syntactic sugar for arrays
  #   object.in? array
  #   => array.include? object
  #
  # ==Example
  #   array=['a','b','c']
  #   object='b'
  #   object.in? array 
  #   => true
  
  def in?(array)
    array.include?(self)
  end
  
end
