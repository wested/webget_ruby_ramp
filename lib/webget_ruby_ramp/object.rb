# -*- encoding: utf-8 -*-

# Object extensions

class Object

  # Syntactic sugar for arrays.
  #
  # Definition:
  #   object.in? array === array.include? object
  #
  # @example
  #   array=['a','b','c']
  #   object='b'
  #   object.in? array 
  #   => true
  #
  # @return [Boolean] true iff this object is included in the array.
  def in?(array)
    array.include?(self)
  end
  
end
