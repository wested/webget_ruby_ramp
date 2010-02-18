require 'csv'
 
# Array extensions

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
      return self.map{|item| prefix + item.to_s + suffix}.ruby_join()
    when 3
      infix =fixes[0].to_s
      prefix=fixes[1].to_s
      suffix=fixes[2].to_s
      return self.map{|item| prefix + item.to_s + suffix}.ruby_join(infix)
    else
      raise ArgumentError, "join() takes 0-3 arguments; you gave #{fixes.size}]"
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
  #   [].rotate! => []
  #
  # Return self
  
  def rotate!
    if size>0
      push item=shift
    end
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


  # Return a new array filled with _count_ calls to choice
  #
  # ==Examples
  #   [1,2,3,4].choices(2) => [3,1]
  #   [1,2,3,4].choices(3) => [4,2,3]
  
  def choices(count)
    arr = Array.new
    count.times { arr << self.choice }
    return arr
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
    size==values.size or raise ArgumentError, "Array size #{size} must match values size #{size}" 
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
    (slice_length.is_a? Integer) or (raise ArgumentError, "slice_length must be an integer")
    (slice_length > 0) or (raise ArgumentError, "slice_length must be > 0")
    arr=[]
    index=0
    while index<length
      arr.push self[index...(index+slice_length)]
      index+=slice_length
    end
    return arr
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
    (number_of_slices.is_a? Integer) or (raise ArgumentError, "number_of_slices must be an integer")
    (number_of_slices > 0) or (raise ArgumentError, "number_of_slices must be > 0")
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
  #   arr=[[1,2,3,4],[3,4,5,6]]
  #   arr.union => [1,2,3,4,5,6]
  #
  # ==Examples with proc
  #   arr.map(&:foo).union
  #   => foos that are in any of the array items
  #
  # ==Example with nil
  #   [].union => []

  def union
    inject{|inj,item| inj | item.to_a } || []
  end


  # Return the intersection of the array's items.
  # In typical usage, each item is an array.
  #
  # ==Examples
  #   arr=[[1,2,3,4],[3,4,5,6]]
  #   arr.intersect
  #   => [3,4]
  #
  # ==Examples with proc
  #   arr.map(&:foo).intersect
  #   => foos that are in all of the array items
  #
  # ==Example with nil
  #   [].intersect => []

  def intersect
    inject{|inj,item| inj & item.to_a } || []
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

  def shifted(number_of_items=1)
    (number_of_items.is_a? Integer) or (raise ArgumentError, "number_of_items must be an integer")
    (number_of_items >= 0) or (raise ArgumentError, "number_of_items must be >= 0")
    slice(number_of_items,self.length-number_of_items)
  end

  alias :car :first
  alias :cdr :shifted
  alias :rest :shifted


  # Delete the first _number_of_items_ items. Returns the array, not the deleted items.
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
  #
  # If _n_ is greater than the array size, then return []

  def shifted!(number_of_items=1)
    (number_of_items.is_a? Integer) or (raise ArgumentError, "number_of_items must be an integer")
    (number_of_items >= 0) or (raise ArgumentError, "number_of_items must be >= 0")
    slice!(0,number_of_items)
    return self
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

  # Returns a CSV (Comma Separated Value) string of this array.
  #
  # ==Example of a one-dimensional array
  #
  #   [1,2,3].to_csv => "1,2,3\n"
  #
  # ==Example of a multi-dimensional array
  #
  #   [[1,2,3],[4,5,6]] => "1,2,3\n4,5,6\n"
  #
  # ==Example of a blank array
  #   
  #   [].to_csv => ""
  #
  # N.b. this method uses the multi-dimensional if the
  # array's first item is also an array.

  def to_csv(ops={})

    return "" if size==0

    generator = RUBY_VERSION >= "1.9" ? CSV : CSV::Writer

    str=''
    if size>0 and self[0].is_a?Array
      generator.generate(str) do |csv|
        self.each do |row|
          csv << row
        end
      end
    else
      generator.generate(str) do |csv|
        csv << self.map{|item| item.to_s}
      end
    end
    return str
  end


  # Returns a TSV (Tab Separated Value) string
  # representation of a multi-dimensional array.
  #
  # Each subarray becomes one 'line' in the output.
  #
  # ==Example of a blank array
  #   
  #   [].to_csv => ""

  def to_tsv(ops={})
    self.map{|row| row.join("\t")+"\n"}.join
  end

  alias to_tdf to_tsv

end
