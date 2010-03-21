# -*- encoding: utf-8 -*-

# Enumberable extensions

module Enumerable


  ########################################################################
  #
  #  typecast
  #  
  ########################################################################

  # Convert an enumerable to a hash.
  #
  # @return [Hash<Object,Object>] a hash of the enumerable's items
  #
  # @example
  #   array=[[:a, :b],[:c, :d],[:e, :f]]
  #   array.to_h => {:a=>:b, :c=>:d, :e=>:f}
  #
  # If a key occurs more than once, then this will automatically 
  # convert the value to an array of the keys' values.
  #
  # @example
  #   array=[[:a,:b],[:a,:c],[:a,:d]]
  #   array.to_h => {:a=>[:b, :c, :d]}

  def to_h
    hash={}
    dupe={}
    each{|key,val|
      if hash.key? key
        if dupe.key? key
          hash[key] << val
        else
          hash[key]=[hash[key]]
          hash[key] << val
          dupe[key]=true
        end
      else
        hash[key]=val
      end
    }
    return hash
  end


  # Convert the enumerable to a hash by mapping each item to a pair [index ,item]
  #
  # @return [Hash<Integer,Object>] a hash of the enumerable's items
  #
  # @example
  #   strings = ["red","blue","green"]
  #   strings.index_by{|a| a.size]}
  #   => {3 => "red", 4 => "blue", 5 => "green"}
  #
  # Rails has this method.
  #
  # From http://stackoverflow.com/questions/412771/cleanest-way-to-create-a-hash-from-an-array
  #
  # @see #hash_by

  def index_by
    inject({}) {|hash, elem| hash.merge!(yield(elem) => elem) }
  end


  # Convert the enumerable to a hash by mapping each item to a pair [item, new item]
  #
  # @return [Hash<Object,Object>] a hash of the enumerable's items
  # 
  # @example
  #   strings = ["red","blue","green"]
  #   strings.hash_by{|a| [a.size, a.upcase]}
  #   => {3 => "RED", 4 => "BLUE", 5 => "GREEN"}
  #
  # @see #index_by

  def hash_by
    map{|item| yield(item)}.to_h
  end



  ########################################################################
  #
  #  map_to_xxx
  #  
  ########################################################################


  # Map each item => item.id
  #
  # @return [Enumerable<Object>] an list of each item.id
  #
  # @example
  #   users = User.find(:all)
  #   users.map_id => [1,2,3,4,...]
  #
  # A typical use is to convert a list of ActiveRecord items to a list of id items.
  #
  # This method is a fast way to get the same results as items.map(&:id)

  def map_id
    map{|item| item.id}
  end


  # Map each item => item.to_a
  #
  # @return [Enumberable<Array<Object>>] a list of each item.to_a
  #
  # @example
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
    map{|item| [item]}
  end


  # Map each item => item.to_f
  #
  # @return [Enumerable<Float>] a list of each item.to_f
  #
  # @example
  #   strings = ["1","2","3"]
  #   strings.map_to_f => [1.0, 2.0, 3.0]
  #
  # A typical use is to convert a list of String items to a list of float items.
  #
  # This method is a fast way to get the same results as items.map(&:to_f)

  def map_to_f
    map{|item| item.to_f}
  end


  # Map each item => item.to_i
  #
  # @return [Enumerable<Integer>] a list of each item.to_i
  #
  # @example
  #   strings = ["1","2","3"]
  #   strings.map_to_i => [1, 2, 3]  
  #
  # A typical use is to convert a list of String items to a list of integer items.
  #
  # This method is a fast way to get the same results as items.map(&:to_i)

  def map_to_i
    map{|item| item.to_i}
  end


  # Map each item => item.to_s
  #
  # @return [Enumerable<String>] a list of each item.to_s
  #
  # @example
  #   numbers = [1, 2, 3]
  #   numbers.map_to_s => ["1", "2", "3"]  
  #
  # A typical use is to convert a list of Numeric items to a list of String items.
  #
  # This method is a fast way to get the same results as items.map(&:to_s)
 
  def map_to_s
    map{|item| item.to_s}
  end


  # Map each item => item.to_sym
  #
  # @return [Enumerable<Symbol>] a list of each item.to_sym
  #
  # @example
  #   strings = ["foo", "goo", "hoo"]
  #   strings.map_to_sym => [:foo, :goo, :hoo]
  #
  # A typical use is to convert a list of Object items to a list of Symbol items.
  #
  # This method is a fast way to get the same results as items.map(&:to_sym)

  def map_to_sym
    map{|item| item.to_sym}
  end


  # Map each item and its index => a new output
  #
  # @return [Enumerable<Object>] an list of each item transformed by the block
  # @see Enumerable#map
  # @see Enumerable#each_with_index
  #
  # @example
  #   strings = ["a", "b", "c"]
  #   strings.map_with_index{|string,index| "#{string}#{index}"}
  #    => ["a0, "b1", "c3"]

  def map_with_index
    index=-1
    map{|item| index+=1; yield(item,index)}
  end


  ########################################################################
  #
  #  select
  #  
  ########################################################################
  
  
  # @example
  #   enum.select_while {|obj| block }
  #    => array
  #
  # @return [Array<Object>] the leading elements for which block is not false or nil.

  def select_while
    arr = []
    each{|item| yield(item) ? (arr << item) : break}
    return arr
  end


  # @example
  #   enum.select_until {|obj| block }
  #    => array
  #
  # @return [Array<Object>] the leading elements for which block is false or nil.

  def select_until
    arr = []
    each{|item| yield(item) ? break : (arr << item)}
    return arr
  end


  # Calls block with two arguments, the item and its index, for each item in enum.
  #
  # @example
  #   enum.select_with_index {|obj,i| block } 
  #   => array
  #
  # @return [Array<Object> the leading elements for which block is not false or nil.

  def select_with_index
    index = 0
    arr = []
    each{|item| 
      if yield(item,index)
        arr << item
        index+=1
      else
        break
      end
    }
    return arr
  end


  ########################################################################
  #
  #  bisect
  #  
  ########################################################################

  # @example
  #   enum.bisect {|obj| block}
  #   => array of positives, array of negatives
  # 
  # @return [Array<Array<Object>] an array of two arrays:
  #    the first array is the elements for which block is true,
  #    the second array is the elements for which block is false or nil.

  def bisect
    accept=[]
    reject=[]
    each{|item| 
     if yield(item)
      accept << item
     else
      reject << item
     end
    }
    return accept,reject
  end


  ########################################################################
  #
  #  nitems
  #  
  ########################################################################
  
  
  # @example
  #   enum.nitems_while {| obj | block }
  #    => number of items
  # 
  # @return [Integer] the number of leading elements for which block is not false or nil.

  def nitems_while
    num = 0
    each{|item| yield(item) ? (num+=1) : break}
    return num
  end


  # @example
  #   enum.nitems_until {| obj | block }
  #   => number of items
  #
  # @return [Integer] the number of leading elements for which block is false.

  def nitems_until
    num = 0
    each{|item|
      if yield(item) 
        break
      else
        num+=1
      end
    }
    return num
  end


  # Calls block with two arguments, the item and its index, for each item in enum.
  #
  # @example
  #   enum.nitems_with_index {|obj,i| block }
  #    => number of items
  #
  # @return [Integer] the number of leading elements for which block is true.

  def nitems_with_index
    index = 0
    each{|item| yield(item,index) ? (index+=1) : break}
    return index
  end


  # Shortcut to Array#join to concatenate the items into a string
  #
  # @example
  #   ["foo", "goo", "hoo"].join
  #   => "foogoohoo"
  #
  # @return [String] concatenated string
  #
  # @see Array#join

  def join(*op)
   to_a.join(*op)
  end


  ########################################################################
  #
  #  set math
  #  
  ########################################################################


  # @return [Boolean] true if this  _enum_ intersects another _enum_.
  #
  # This implementation uses #to_a and array intersection.
  # A developer may want to optimize this implementation for
  # other classes, such as detecting whether a range intersects
  # another range simply by comparing the ranges' min/max values.
  #
  # @example
  #   ['a','b','c'].intersect?(['c','d','e'] => true
  #   ['a','b','c'].intersect?(['d','e','f'] => false

  def intersect?(enum)
    return ((self===enum and self.to_a.size>0) or ((self.to_a & enum.to_a).size>0))
  end


  # @return [Array] the cartesian product of the enumerations.
  #
  # @see http://en.wikipedia.org/wiki/Cartesian_product
  #
  # This is the fastest implementation we have found.
  # It returns results in typical order.
  #
  # @author Thomas Hafner
  # @see http://www.ruby-forum.com/topic/95519
  #
  # For our benchmarks, we also compared these:
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


  # Calculate the power set.
  #
  # @return [Array<Array<Object>>] the power set: an array with all subsets of the enum's elements.
  # @see http://en.wikipedia.org/wiki/Power_set
  #
  # This implementation is from the blog post below:
  # @see http://johncarrino.net/blog/2006/08/11/powerset-in-ruby/
  #
  # @example
  #   [1,2,3].power_set.sort
  #   =>  [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]

  def power_set
    inject([[]]){|c,y|r=[];c.each{|i|r<<i;r<<i+[y]};r}
  end

end
