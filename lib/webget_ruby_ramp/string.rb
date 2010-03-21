# -*- encoding: utf-8 -*-

# String extensions

class String


 # @return [String] self, with words capitalized
 # @example 
 #   "foo goo hoo".capitalize_words
 #    => "Foo Goo Hoo"

 def capitalize_words
  split(/\b/).map{|word| word.capitalize }.join
 end


 # @return [Array<String>] an array that is the string split into words, i.e. split(\W*\b\*)
 # @example
 #   "foo goo hoo".words
 #   => ["foo", "goo", "hoo"]

 def words
  split(/\W*\b\W*/)
 end


 # @return [Array<String>] an array that is the string split at tabs, i.e. split(/\t/)
 # @example
 #   "foo\tgoo\thoo".split_tab
 #   => ["foo", "goo", "hoo"]

 def split_tab
  split(/\t/)
 end


 # This is useful to split a TSV (Tab Separated Values) string
 # into an array of rows, and each row into an array of fields.
 #
 # @return [Array<String>] an array that is the string split at newlines, then tabs.
 #
 # @example
 #   "foo\tgoo\thoo\n"ioo\tjoo\tkoo\nloo\tmoo\tnoo".split_tsv
 #   => [["foo", "goo", "hoo"], ["ioo", "joo", "koo"], ["loo", "moo", "noo"]]

 def split_tsv
   split(/\n/).map{|line| line.split(/\t/)}
 end


 # @return [String] self in lowercase,
 #    with any non-word-characters
 #    replaced with single underscores (aka low dashes).
 #
 # @example
 #   'Foo Goo Hoo' => 'foo_goo_hoo'
 #   'Foo***Goo***Hoo' => 'foo_goo_hoo'

 def lowcase
  downcase.gsub(/[_\W]+/,'_')
 end


 # @return [String] the string as an XML id, which is the same as #lowcase
 #
 # @example
 #   "Foo Hoo Goo" => 'foo_goo_hoo'
 #   "Foo***Goo***Hoo" => 'foo_goo_hoo'

 def to_xid
  self.lowcase
 end

 # Ruby String#to_class method to convert from a String to a class
 #
 # From Mirage at http://infovore.org/archives/2006/08/02/getting-a-class-object-in-ruby-from-a-string-containing-that-classes-name/
 #
 # @return [Class] the string converted to a class 

 def to_class
  split('::').inject(Kernel) {|scope, const_name| scope.const_get(const_name)}
 end


 # Increment the rightmost natural number 
 #
 # @return [String] the string with an incremented rightmost number
 #
 # @example
 #   'foo5bar'.increment => 'foo4bar'
 #   'foo5bar'.increment(3) => 'foo8bar'
 #   'foo9bar'.increment => 'foo10bar'
 #
 # @see String#decrement

 def increment(step=1)
  self=~/\d+/ ? $`+($&.to_i+step).to_s+$' : self
 end


 # Decrement the rightmost natural number
 # 
 # @return [String] the string with a decremented rightmost number
 #
 # @example
 #   'foo5bar'.decrement => 'foo4bar'
 #   'foo5bar'.decrement(3) => 'foo2bar'
 #   'foo10bar'.derement => 'foo9bar'
 #
 # @see String#increment

 def decrement(step=1)
  self=~/\d+/ ? $`+($&.to_i-step).to_s+$' : self
 end


 # @return [String] the previous character, with a changed flag and carry flag
 #
 # @example
 #   String.prev_char('n') => 'm', true, false   # change 
 #   String.prev_char('a') => 'z', true, true    # change & carry
 #   String.prev_char('6') => '5', true, false   # change
 #   String.prev_char('0') => '9', true, true    # change & carry
 #   String.prev_char('-') => '-', false, false  # unchanged

 def self.prev_char(chr) #=> prev_char, changed_flag, carry_flag
  case chr
  when '1'..'9', 'B'..'Z', 'b'..'z'
    pos=(chr.respond_to?(:ord) ? chr.ord : chr[0])
    return (pos-1).chr, true, false
  when '0'
    return '9', true, true
  when 'A'
    return 'Z', true, true
  when 'a'
    return 'z', true, true
  else
    return chr, false, false
  end
 end

 # @return [String] the previous string
 #
 # @see String#next
 #
 # @example
 #   '888'.prev => '887'
 #   'n'.prev => 'm'
 #   'N'.prev => 'M'
 #
 # @example with carry
 #   '880'.prev => '879'
 #   'nna'.prev => 'nmz'
 #   'NNA'.prev => 'NMZ'
 #   'nn0aA'.prev => 'nm9zZ'
 
 def prev
  self.clone.prev!
 end


 # Do String#prev in place
 #
 # @return [String] self

 def prev!
  return self if length==0
  index=length-1 # rightmost
  while true do
   chr=self[index].chr
   prev_chr,changed_flag,carry_flag=String.prev_char(chr)
    return self if !changed_flag
   self[index]=prev_chr
   return self if !carry_flag
   index-=1
   return nil if index<0
  end
  return self
 end

 alias pred  prev   # String#pred : predecessor :: String#succ : successor
 alias pred! prev!
 
 class << self
  alias_method :pred_char, :prev_char
 end

 # Helpful constants

 LOWERCASE_ENGLISH_CHARS = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
 UPPERCASE_ENGLISH_CHARS = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']


 ##
 #
 #  Lorem Ipsum random text generator
 #
 ##
 
 # @return [Integer[ a random length suitable for a "lorem ipsum" string.
 #
 # This method uses 1+rand(10)
 #
 # @example
 #    String.lorem_length => 3
 #    String.lorem_length => 9
 #    String.lorem_length => 5

 def self.lorem_length
  1+rand(10)
 end

 # @return [String] a random string suitable for "lorem ipsum" text.
 #
 # @example
 #   String.lorem => "galkjadscals"
 #   String.lorem(4) => "qtgf"
 #
 # This method chooses from lowercase letters a-z.
 #
 # This method defaults to length = self.lorem_length.
 
 def self.lorem(length=self.lorem_length)
  ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'].choices(length).join
 end


end

