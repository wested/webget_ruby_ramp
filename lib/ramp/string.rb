class String


 # Return the string split into words, i.e. split(\W*\b\*)
 def words
  split(/\W*\b\W*/)
 end

 # Return the string split at tabs, i.e. split(/\t/)
 def split_tab
  split(/\t/)
 end

 def capitalize_words
  split(/\b/).map{|x| x.capitalize }.join
 end

 # Ruby String#to_class method to convert from a String to a class
 #
 # From Mirage at http://infovore.org/archives/2006/08/02/getting-a-class-object-in-ruby-from-a-string-containing-that-classes-name/
 def to_class
  split('::').inject(Kernel) {|scope, const_name| scope.const_get(const_name)}
 end


 # Increment the rightmost natural number 
 #
 # ==Example
 #   'foo5bar'.increment => 'foo4bar'
 #   'foo5bar'.increment(3) => 'foo8bar'
 #   'foo9bar'.increment => 'foo10bar'
 #
 # - see String#decrement

 def increment(step=1)
  s=~/\d+/ ? $`+($&.to_i+step).to_s+$' : s
 end


 # Decrement the rightmost natural number
 # 
 # ==Example
 #   'foo5bar'.decrement => 'foo4bar'
 #   'foo5bar'.decrement(3) => 'foo2bar'
 #   'foo10bar'.derement => 'foo9bar'
 #
 # - see String#increment

 def decrement(step=1)
  s=~/\d+/ ? $`+($&.to_i-step).to_s+$' : s
 end


 # Return the previous character, with a changed flag and carry flag
 #
 # ==Examples
 #   String.prev_char('n') => 'm', true, false   # change 
 #   String.prev_char('a') => 'z', true, true    # change & carry
 #   String.prev_char('6') => '5', true, false   # change
 #   String.prev_char('0') => '9', true, true    # change & carry
 #   String.prev_char('-') => '-', false, false  # unchanged

 def self.prev_char(c) #=> prev_char, changed_flag, carry_flag
  case c
  when '1'..'9', 'B'..'Z', 'b'..'z'
    i=(c.respond_to?(:ord) ? c.ord : c[0])
    return (i-1).chr, true, false
  when '0'
    return '9', true, true
  when 'A'
    return 'Z', true, true
  when 'a'
    return 'z', true, true
  else
    return c, false, false
  end
 end

 # Return the previous string
 #
 #  c.f. String#next
 #
 # ==Examples
 #   '888'.prev => '887'
 #   'n'.prev => 'm'
 #   'N'.prev => 'M'
 #
 # ==Examples with carry
 #   '880'.prev => '879'
 #   'nna'.prev => 'nmz'
 #   'NNA'.prev => 'NMZ'
 #   'nn0aA'.prev => 'nm9zZ'
 
 def prev
  self.clone.prev!
 end

 # Do String#prev in place
 def prev!
  return self if length==0
  i=length-1 # rightmost
  while true do
   c=self[i].chr
   prev_c,changed_flag,carry_flag=String.prev_char(c)
    return self if !changed_flag
   self[i]=prev_c
   return self if !carry_flag
   i-=1
   return nil if i<0
  end
 end

 alias pred  prev   # String#pred : predecessor :: String#succ : successor
 alias pred! prev!

 class << self
  alias_method :pred_char, :prev_char
 end

end

