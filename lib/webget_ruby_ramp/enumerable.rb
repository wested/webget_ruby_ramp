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


  # Convert the enumerable to a hash by mapping each item to a key,item pair.
  #
  # ==Example
  #   strings = ["red","blue","green"]
  #   strings.index_by{|a| a.size]}
  #   => {3 => "red", 4 => "blue", 5 => "green"}
  #
  # Rails has this method.
  #
  # From http://stackoverflow.com/questions/412771/cleanest-way-to-create-a-hash-from-an-array
  #
  # Compare #hash_by

  def index_by
    inject({}) {|hash, elem| hash.merge!(yield(elem) => elem) }
  end


  # Convert the enumerable to a hash by mapping each item to a key,value pair.
  #
  # ==Example
  #   strings = ["red","blue","green"]
  #   strings.hash_by{|a| [a.size, a.titlecase]}
  #   => {3 => "red", 4 => "blue", 5 => "green"}
  #
  # Compare #index_by

  def hash_by
    map{|x| yield(x)}.to_h
  end



  ########################################################################
  #
  #  map_to_xxx
  #  
  ########################################################################


  # Map each item => item.id
  #
  # ==Example
  #   users = User.find(:all)
  #   users.map_id => [1,2,3,4,...]
  #
  # A typical use is to convert a list of ActiveRecord items to a list of id items.
  #
  # This method is a fast way to get the same results as items.map(&:id)

  def map_id
    map{|x| x.id}
  end


  # Map each item => item.to_a
  #
  # ==Example
  #   set1 = Set.new([:a,:b,:c])
  #   set2 = Set.new([:d,:e,:f])
  #   set3 = Set.new([:g,:h,:i])
  #   sets = [set1, set2, set3]
  #   sets.map_to_a => [[:a, :b, :c], [:d, :e, :f], [:g, :h, :i]]
  #
  # A typical use is to convert a list with Set items to a list of Array items,
  # so you can more easily iterate over the the Array items.
  #
  # See http://www.ruby-doc.org/core/classes/Enumerable.html#M003148

  def map_to_a
    map{|x| [x]}
  end


  # Map each item => item.to_f
  #
  # ==Example
  #   strings = ["1","2","3"]
  #   strings.map_to_f => [1.0, 2.0, 3.0]
  #
  # A typical use is to convert a list of String items to a list of float items.
  #
  # This method is a fast way to get the same results as items.map(&:to_f)

  def map_to_f
    map{|x| x.to_f}
  end


  # Map each item => item.to_i
  #
  # ==Example
  #   strings = ["1","2","3"]
  #   strings.map_to_i => [1, 2, 3]  
  #
  # A typical use is to convert a list of String items to a list of integer items.
  #
  # This method is a fast way to get the same results as items.map(&:to_i)

  def map_to_i
    map{|x| x.to_i}
  end


  # Map each item => item.to_s
  #
  # ==Example
  #   numbers = [1, 2, 3]
  #   numbers.map_to_s => ["1", "2", "3"]  
  #
  # A typical use is to convert a list of Numeric items to a list of String items.
  #
  # This method is a fast way to get the same results as items.map(&:to_s)
 
  def map_to_s
    map{|x| x.to_s}
  end


  # Map each item => item.to_sym
  #
  # ==Example
  #   strings = ["foo", "goo", "hoo"]
  #   strings.map_to_sym => [:foo, :goo, :hoo]
  #
  # A typical use is to convert a list of Object items to a list of Symbol items.
  #
  # This method is a fast way to get the same results as items.map(&:to_sym)

  def map_to_sym
    map{|x| x.to_sym}
  end


  # Map each item and its index => a new output
  #
  # cf. Enumerable#map, Enumerable#each_with_index
  #
  # ==Example
  #
  #   strings = ["a", "b", "c"]
  #   strings.map_with_index{|string,index| "#{string}#{index}"}
  #    => ["a0, "b1", "c3"]

  def map_with_index
    i=-1
    map{|x| i+=1; yield(x,i)}
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
  #  bisect
  #  
  ########################################################################

  # enum.bisect {|obj| block} => array of positives, array of negatives
  # Returns two arrays: the first contains the elements for which block is
  # true, the second contains the elements for which block is false or nil.

  def bisect
    a=[]
    b=[]
    each{|x| 
     if yield(x)
      a << x
     else
      b << x
     end
    }
    return a,b
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
