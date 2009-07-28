# -*- coding: utf-8 -*-
module Enumerable


  ########################################################################
  #
  #  typecast
  #  
  ########################################################################

  # Convert an enumerable to a hash.
  #
  # ==Example
  #   array=[[:a, :b],[:c, :d],[:e, :f]]
  #   array.to_h => {:a=>:b, :c=>:d, :e=>:f}
  #
  # If a key occurs more than once, then this will automatically 
  # convert the value to an array of the keys' values.
  #
  # ==Example
  #   array=[[:a,:b],[:a,:c],[:a,:d]]
  #   array.to_h => {:a=>[:b, :c, :d]}

  def to_h
    h={}
    dupe={}
    each{|k,v|
      if h.key? k
        if dupe.key? k
          h[k] << v
        else
          h[k]=[h[k]]
          h[k] << v          
          dupe[k]=true
        end
      else
        h[k]=v
      end
    }
    return h
  end


  ########################################################################
  #
  #  map
  #  
  ########################################################################
  

  # map item => item.id
  # returns the id of an Enumerable object; *requires* that the object respond to an 'id' message
  def map_id
    map{|x| x.id}
  end


  # map item => item.to_a
  # typical usage: convert a list of Sets to a list of Arrays, to more easily walk the items
  # see [Enumerable.to_a](http://www.ruby-doc.org/core/classes/Enumerable.html#M003148)
  def map_to_a
    map{|x| [x]}
  end


  # map item => item.to_f
  # typical usage: convert a list of integers to a list of floats
  def map_to_f
    map{|x| x.to_f}
  end


  # map item => item.to_i
  # typical usage: convert a list of floats to a list of integers
  def map_to_i
    map{|x| x.to_i}
  end


  # map item => item.to_s
  # typical usage: convert a list of items to a list of their string representations
  def map_to_s
    map{|x| x.to_s}
  end


  # map item => item.to_sym
  # typical usage: convert a list of items to a list of their symbolic representations
  def map_to_sym
    map{|x| x.to_sym}
  end


  ########################################################################
  #
  #  select
  #  
  ########################################################################
  
  
  # enum.select_while {|obj| block } => array
  # Returns an array containing the leading elements for which block is not false or nil.

  def select_while
    a = []
    each{|x| yield(x) ? (a << x) : break}
    return a
  end


  # enum.select_until {|obj| block } => array
  # Returns an array containing the leading elements for which block is false or nil.

  def select_until
    a = []
    each{|x| yield(x) ? break : (a << x)}
    return a
  end


  # enum.select_with_index {|obj,i| block } => array
  # Calls block with two arguments, the item and its index, for each item in enum.
  # Returns an array containing the leading elements for which block is not false or nil.

  def select_with_index
    i = 0
    a = []
    each{|x| 
      if yield(x,i)
        a << x
        i+=1
      else
        break
      end
    }
    return a
  end


  ########################################################################
  #
  #  nitems
  #  
  ########################################################################
  
  
  # enum.nitems_while {| obj | block } => number of items
  # Returns the number of leading elements for which block is not false or nil.

  def nitems_while
    n = 0
    each{|x| yield(x) ? (n+=1) : break}
    return n
  end


  # enum.nitems_until {| obj | block } => number of items
  # Returns the number of leading elements for which block is false.

  def nitems_until
    n = 0
    each{|x|
      if yield(x) 
        break
      else
        n+=1
      end
    }
    return n
    irb
  end


  # enum.nitems_with_index {|obj,i| block } => number of items
  # Calls block with two arguments, the item and its index, for each item in enum.
  # Returns the number of leading elements for which block is true.

  def nitems_with_index
    i = 0
    each{|x| yield(x,i) ? (i+=1) : break}
    return i
  end


  # Shortcut to Array#join to concatenate the items into a string

  def join(prefix=nil,suffix=nil)
   to_a.join(prefix,suffix)
  end


  ########################################################################
  #
  #  set math
  #  
  ########################################################################


  # Returns true if this  _enum_ intersects another _enum_.
  #
  # @nb This implementation uses #to_a and array intersection.
  # A developer may want to optimize this implementation for
  # other classes, such as detecting whether a range intersects
  # another range simply by comparing the ranges' min/max values.
  #
  # ==Examples
  #   ['a','b','c'].intersect?(['c','d','e'] => true
  #   ['a','b','c'].intersect?(['d','e','f'] => false

  def intersect?(enum)
    return ((self===enum and self.to_a.size>0) or ((self.to_a & enum.to_a).size>0))
  end


  # Return the cartesian product of the enumerations.
  # http://en.wikipedia.org/wiki/Cartesian_product
  #
  # This is the fastest implementation we have found.
  # It returns results in typical order.
  #
  # By Thomas Hafner
  # See http://www.ruby-forum.com/topic/95519
  #
  # For our benchmarks, we also compared thesk:
  # - By William James, http://www.ruby-forum.com/topic/95519
  # - By Brian Schröäer, http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/151857

  def self.cartesian_product(*enums)
    result = [[]]
    while [] != enums
      t, result = result, []
      b, *enums = enums
      t.each do |a|
        b.each do |n|
          result << a + [n]
        end
      end
    end
    result
  end

  def cartesian_product(*enums)
    Enumerable.cartesian_product(self,*enums)
  end


  # Return the power set: an array with all subsets of the enum's elements.
  # http://en.wikipedia.org/wiki/Power_set
  #
  # This implementation is from
  # http://johncarrino.net/blog/2006/08/11/powerset-in-ruby/
  #
  # ==Example
  #   [1,2,3].power_set.sort
  #   =>  [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]

  def power_set
    inject([[]]){|c,y|r=[];c.each{|i|r<<i;r<<i+[y]};r}
  end

end
