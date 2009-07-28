# -*- coding: utf-8 -*-
class String

  ACCENTS =  Hash[*'
 à a á a â a ã a ä a å a ā a ă a
 æ ae
 ď d đ d             
 ç c ć c č c ĉ c ċ c
 è e é e ê e ë e ē e ę e ě e ĕ e ė e           
 ƒ f              
 ĝ g ğ g ġ g ģ g             
 ĥ h ħ h             
 ì i ì i í i î i ï i ī i ĩ i ĭ i            
 į j ı j ĳ j ĵ j             
 ķ k ĸ k             
 ł l ľ l ĺ l ļ l ŀ l             
 ñ n ń n ň n ņ n ŉ n ŋ n            
 ò o ó o ô o õ o ö o ø o ō o ő o ŏ o ŏ o           
 œ oek             
 ą q              
 ŕ r ř r ŗ r             
 ś s š s ş s ŝ s ș s             
 ť t ţ t ŧ t ț t             
 ù u ú u û u ü u ū u ů u ű u ŭ u ũ u ų u           
 ŵ w              
 ý y ÿ y ŷ y             
 ž z ż z ź z             
 '.split]


 # Return the string with words capitalized

 def capitalize_words
  split(/\b/).map{|x| x.capitalize }.join
 end


 # Return the string split into words, i.e. split(\W*\b\*)

 def words
  split(/\W*\b\W*/)
 end


 # Return the string split at tabs, i.e. split(/\t/)

 def split_tab
  split(/\t/)
 end


 # Return the string in lowercase, with any non-word-characters
 # replaced with single underscores (aka low dashes).
 #
 # ==Example
 #   'Foo Goo Hoo' => 'foo_goo_hoo'
 #   'Foo***Goo***Hoo' => 'foo_goo_hoo'

 def lowcase
  downcase.gsub(/[_\W]+/,'_')
 end


 # Return the string as an XML id, which is the same as #lowcase
 #
 # ==Example
 #   "Foo Hoo Goo" => 'foo_goo_hoo'
 #   "Foo***Goo***Hoo" => 'foo_goo_hoo'

 def to_xid
  self.lowcase
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
  self=~/\d+/ ? $`+($&.to_i+step).to_s+$' : self
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
  self=~/\d+/ ? $`+($&.to_i-step).to_s+$' : self
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

 # Helpful constants

 LOWERCASE_ENGLISH_CHARS = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
 UPPERCASE_ENGLISH_CHARS = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']


 ##
 #
 #  Lorem Ipsum random text generator
 #
 ##
 
 # Return a random length suitable for a "lorem ipsum" string.
 #
 # This method uses 1+rand(10)

 def self.lorem_length
  1+rand(10)
 end

 # Return a random string suitable for "lorem ipsum" text.
 #
 # This method chooses from lowercase letters a-z.
 #
 # This method defaults to length = self.lorem_length.
 
 def self.lorem(length=self.lorem_length)
  ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'].choices(length).join
 end


end

