class Array


  # Alias join because we're going to override it

  alias :ruby_join :join


  # Concatenate the items into a string by join.
  #
  # ==Typical Array#join with infix
  #   list=['a','b','c']
  #   list.join("*") => "a*b*c"
  #
  # ==Improved join with infix, prefix, suffix
  #   list=['a','b','c']
  #   list.join("*","[","]") => "[a]*[b]*[c]"
  #
  # ==Improved join with just prefix and suffix
  #   list=['a','b','c']
  #   list.join("[","]") => "[a][b][c]"

  def join(*fixes)
    if fixes.is_a?(String) then return self.ruby_join(fixes) end
    case fixes.size
    when 0
      return self.ruby_join()
    when 1
      return self.ruby_join(fixes[0])
    when 2
      prefix=fixes[0].to_s
      suffix=fixes[1].to_s
      return self.map{|s| prefix + s.to_s + suffix}.ruby_join()
    when 3
      infix =fixes[0].to_s
      prefix=fixes[1].to_s
      suffix=fixes[2].to_s
      return map{|s| prefix + s.to_s + suffix}.ruby_join(infix)
    else
      raise "join(fixes[#{fixes.size}]"
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
  # LIST PROCESSING
  #
  ##############################################################

  # Returns the rest of the items of self, after a shift.
  #
  # ==Example
  #   list=['a','b','c']
  #   list.shift => 'a'
  #   list.shifted => ['b','c']
  #
  # ==Example with length
  #   list.shifted(0) => ['a','b','c']
  #   list.shifted(1) => ['b','c']
  #   list.shifted(2) => ['c']
  #   list.shifted(3) => []
  #
  # Ruby programmers may prefer this alias wording:
  #   list.first => 'a'
  #   list.rest => ['b','c']
  #
  # LISP programmers may prefer this alias wording:
  #   list.car => 'a'
  #   list.cdr => ['b','c']
  #

  def shifted(n=1)
   slice(n,self.length-n)
  end

  alias :car :first
  alias :cdr :shifted
  alias :rest :shifted


  # Delete the first _n_ items. Returns the array, not the deleted items.
  # 
  # ==Example
  #   list=['a','b','c']
  #   list.shifted!
  #   list => ['b','c']
  #
  # ==Example with length:
  #   list=['a','b','c']
  #   list.shifted!(2)
  #   list => ['c']

  def shifted!(n=1)
   slice!(n,self.length-n)
  end

  alias :cdr! :shifted!
  alias :rest! :shifted!


  # Randomly arrange the array items.
  #
  # This implementation is optimized for speed, not for memory use.
  # See http://codeidol.com/other/rubyckbk/Arrays/Shuffling-an-Array/
  #
  # This method definition is skipped if Array#shuffle! is already defined.
  #
  # ==Example
  #   list=
  #   list=['a','b','c']
  #   list.shuffle!
  #   list => ['c','a','b']

  if !instance_methods.include?('shuffle!')
    def shuffle!  
      each_index do |i| 
        j = rand(length-i) + i
        self[j], self[i] = self[i], self[j]  
      end
    end
  end

  # Return the array items in random order.
  #
  # This implementation is optimized for speed, not for memory use.
  # See http://codeidol.com/other/rubyckbk/Arrays/Shuffling-an-Array/
  #
  # This method definition is skipped if Array#shuffle is already defined.
  # For example, Ruby 1.8.7 Array#shuffle is already defined.
  #
  # ==Example
  #   list=
  #   list=['a','b','c']
  #   list.shuffle!
  #   list => ['c','a','b']

  if !instance_methods.include?('shuffle') and instance_methods.include?('shuffle!')
    def shuffle  
      dup.shuffle!  
    end
  end


  ##############################################################
  # 
  # CASTS
  #
  ##############################################################

  require 'csv'
 
  # Returns a CSV (Comma Separated Value) string
  # representation of a multi-dimensional array.
  #
  # Each subarray becomes one 'line' in the output.

  def to_csv(ops={})
    s=''
    CSV::Writer.generate(s) do |csv|
      self.each do |row|
        csv << row
      end
    end
    return s
  end


  # Returns a TSV (Tab Separated Value) string
  # representation of a multi-dimensional array.
  #
  # Each subarray becomes one 'line' in the output.

  def to_tsv(ops={})
    self.map{|row| row.join("\t")+"\n"}.join
  end

  alias to_tdf to_tsv

end
