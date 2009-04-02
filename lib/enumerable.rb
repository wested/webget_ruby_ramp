module Enumerable


  ########################################################################
  #
  #  map
  #  
  ########################################################################
  

  #  map item => item.id

  def map_id
    map{|x| x.id}
  end


  # map item => item.to_sym

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


  # Concatenate the items into a string.
  #
  # ==Example
  #   arr=['anne','beth','cate']
  #   arr.cat => "annebethcate"
  #
  # You can optionally provide a prefix and suffix.
  #
  # ==Example
  #   arr.cat("+") => "+anne+beth+cate"
  #   arr.cat("+","-") => "+anne-+beth-+cate-"
  #
  # You can easily wrap items in HTML tags.
  #
  # ==Example
  #   arr=['anne','beth','cate']
  #   arr.cat("<li>","</li>\n")
  #   =>
  #   <li>anne</li>
  #   <li>beth</li>
  #   <li>cate</li>

  def cat(prefix=nil,suffix=nil)
    if prefix
      if suffix
        inject(""){|sum,s| sum += prefix + s.to_s + suffix}
      else
        inject(""){|sum,s| sum += prefix + s.to_s }
      end
    else
      inject(""){|sum,s| sum += s.to_s }
    end
  end



end
