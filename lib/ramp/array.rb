class Array

  alias :ruby_join :join

  # Improved join to concatenate the items into a string
  #
  # ==Typical Array#join
  #   list=['anne','beth','cate']
  #   list.join
  #    =>
  #   "annebethcate"
  #
  # ==Typical Array#join with infix
  #   list=['anne','beth','cate']
  #   list.join("*") 
  #   =>
  #   "anne*beth*cate"
  #
  # ==Improved join with prefix and suffix
  #   list=['anne','beth','cate']
  #   list.join("+","-")
  #    =>
  #    "+anne-+beth-+cate-"
  #
  # ==Improved join with infix and prefix and suffix
  #   list=['anne','beth','cate']
  #   list.join("*","+","-")
  #    =>
  #    "+anne-*+beth-*+cate-"
  #
  # ==Example of wrapping items in HTML tags
  #   list=['anne','beth','cate']
  #   list.join("<li>","</li>\n")
  #   =>
  #   <li>anne</li>
  #   <li>beth</li>
  #   <li>cate</li>

  def join(*fixes)
    case fixes.size
    when 1
      return self.ruby_join(fixes[0])
    when 2
      prefix,suffix=fixes
      return inject(""){|sum,s| sum += prefix + s.to_s + suffix} 
    when 3
      infix,prefix,suffix=fixes
      return inject(""){|sum,s| sum += prefix + s.to_s + suffix}.ruby_join(infix)
    else
      raise "join(fixes["+fixes.size+"]"
    end
  end


  # Return true if size > 0
  #
  # ==Examples
  #   [1,2,3].size? => true
  #   [].size? => false

  def size?
    return size>0
  end


  # Move the first item to the last by using Array#shift and Array#push
  #
  # ==Examples
  #   [1,2,3,4].rotate! => [2,3,4,1]
  #   ['a','b','c'].rotate! => ['b','c','a']
  #
  # Return self
  
  def rotate!
    push x=shift
    self
  end

  
  # Return a random item from the array
  #
  # ==Examples
  #   [1,2,3,4].choice => 2
  #   [1,2,3,4].choice => 4
  #   [1,2,3,4].choice => 3
  #
  # Implemented in Ruby 1.9
  
  def choice
    self[Kernel.rand(size)]
  end


  # Return a new array filled with _n_ calls to choice
  #
  # ==Examples
  #   [1,2,3,4].choices(2) => [3,1]
  #   [1,2,3,4].choices(3) => [4,2,3]
  
  def choices(n)
    a = Array.new
    n.times { a << self.choice }
    return a
  end


  # Return a hash of this array's items as keys
  # mapped onto another array's items as values.
  #
  # ==Example
  #   foo=[:a,:b,:c]
  #   goo=[:x,:y,:z]
  #   foo.onto(goo) => {:a=>:x, :b=>:y, :c=>:z}
  #
  # This is identical to calling foo.zip(values).to_h

  def onto(values)
    zip(values).to_h
  end


  ##############################################################
  # 
  # GROUPINGS
  #
  ##############################################################


  # Return items in groups of _n_ items (aka slices)
  #
  # ==Examples
  #   [1,2,3,4,5,6,7,8].slices(2) => [[1,2],[3,4],[5,6],[7,8]]
  #   [1,2,3,4,5,6,7,8].slices(4) => [[1,2,3,4],[5,6,7,8]]
  #
  # If the slices don't divide evenly, then the last is smaller.
  #
  # ==Examples
  #   [1,2,3,4,5,6,7,8].slices(3) => [[1,2,3],[4,5,6],[7,8]] 
  #   [1,2,3,4,5,6,7,8].slices(5) => [[1,2,3,4,5],[6,7,8]] 

  def slices(slice_length)
    a=[]
    i=0
    while i<length
      a.push self[i...(i+slice_length)]
      i+=slice_length
    end
    return a
  end


  # Divvy the array, like a pie, into _n_ number of slices.
  #
  # If the array divides evenly, then each slice has size/n items.
  #
  # Otherwise, divvy makes a best attempt by rounding up to give
  # earlier slices one more item, which makes the last slice smaller:
  #
  # ==Examples
  #   [1,2,3,4,5].divvy(2) => [[1,2,3],[4,5]]
  #   [1,2,3,4,5,6,7].divvy(3) => [[1,2,3],[4,5,6],[7]]
  #
  # If the array size so small compared to _n_ that there is
  # no mathematical way to _n_ slices, then divvy will return
  # as many slices as it can.
  #
  # ==Examples
  #   [1,2,3,4,5,6].divvy(4) => [[1,2],[3,4],[5,6]]

  def divvy(number_of_slices)
    return slices((length.to_f/number_of_slices.to_f).ceil)
  end


  ##############################################################
  # 
  # COMBINATIONS
  #
  ##############################################################

  
  # Return the union of the array's items.
  # In typical use, each item is an array.
  #
  # ==Example using Ruby Array pipe
  #   a=[1,2,3]
  #   b=[2,3,4]
  #   a | b => [1,2,3,4]
  #
  # ==Example using union method
  #   arr=[a,b]
  #   => [1,2,3,4]
  #
  # This is identical to 
  
  # ==Examples with proc
  #   arr.map(&:foo).union
  #   => foos that are in any of the array items

  def union
    inject{|inj,x| inj | x.to_a }
  end


  # Return the intersection of the array's items.
  # In typical usage, each item is an array.
  #
  # ==Examples
  #   arr=[[1,2,3,4],[2,3,4,5],[3,4,5,6]]
  #   arr.intersect
  #   => [3,4]
  #
  # ==Examples with proc
  #   arr.map(&:foo).intersect
  #   => foos that are in all of the array items

  def intersect
    inject{|inj,x| inj & x.to_a }
  end


  ##############################################################
  # 
  # CASTS
  #
  ##############################################################
  
  require 'csv'
 
  # Returns a CSV-style string representation of a multi-dimensional array
  # Each subarray becomes one 'line' in the output
  def to_csv(ops={})
    s=''
    CSV::Writer.generate(s) do |csv|
      self.each do |row|
        csv << row
      end
    end
    s
  end

end
