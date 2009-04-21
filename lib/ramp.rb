=begin rdoc

= WebGet.com Ramp: methods to ramp up your ruby applications

Ramp is a library of extensions to Ruby base classes, including Array, Date, Enumerable, Hash, Kernel, Numeric, Object, Process, String, Time, and YAML. 

<p>Each has an associated test class, e.g., ArrayTest, DateTest, etc.

== Array

* choice, choices: one or more random elements from an array
* divvy: divides an array, like a pie, into a specified number of slices
* join: same as Array#join with some improvments
* rotate: moves the first element of an array to the end
* slices: divides an array into specified number of equal size sub-arrays ([1,2,3,4,5,6]slices(3) => [[1,2],[3,4],[5,6]])
* union: builds an array containing each of the unique elements of sub-arrays ([[1,2,3,4],[2,3,4,5],[3,4,5,6]].union => [1,2,3,4,5,6])

Dupe methods:
* intersection => '&' (a1 & a2 => [common items])
* size => empty?

== Date

* age_days, age_years
* between: a random date between two specified dates
* to_sql: date as a string formatted as expected for MySQL
* weekday?, weekend?: is date a weekday or on the weekend

== Enumerable

* join
* map_id: returns the id of an Enumerable object; *requires* the object has a field named 'id'
* map_to_sym: symbolifies the object (i.e., enum.to_sym)
* nitems_until, select_until: returns the number of, or an array containing, the leading elements for which block is false or nil.
* nitems_while, select_while: returns the number of items, or an array containing the leading elements, for which block is not false or nil.
* nitems_with_index, select_with_index: calls block with two arguments, the item and its index, for each item in enum. Returns the number of, or an array containing, the leading elements for which block is not false or nil. 

== Hash

* each_value: passes each element to a specified block and updates the element in place in the original hash.
* rolldown, rollup: retrieve arrays of elements from a hash of hashes by top level field name or by interior hash field name, optionally passing a block to execute against each resulting array.
* to_yaml_sort: returns a YAML object, sorted by field name

Dupe methods:
* size? => empty?

== Kernel

* method_name: 
* method_name_of_caller: returns the name of the method which called the current method, or the Nth parent up the call stack if the optional caller_index parameter is passed.

== Numeric

* if: returns 0 if the passed flag is any of: nil, false, 0, [], {} and otherwise returns self
* unless: returns 0 unless the passed flag is any of: nil, false, 0, [], {} and otherwise returns self

== Object

* in?: returns boolean indicating whether the object is a member of the specified array parameter

== Process

Extensions that help debug Ruby programs.

* ps: output of the system 'ps' command, also including aliases, as raw plain text.
* pps: output of the system 'ps' command with each value parsed to appropriate type for the key, e.g., integer, float, etc..

== String

* capitalize_words (alias to titleize/titlecase): ensures the first character of each word is uppercase.
* decrement: decrease the rightmost natural number, defaults to one value lower or by the optional step parameter value.
* increment: increase the rightmost natural number, defaults to one value higher or by the optional step parameter value.
* prev/pred: previous string ("b" => "a", "bbc" => "bbb", "a" => "z", "880" => "879")
* prev/pred: updates variable to the previous string in place (astring = "bbc", astring.prev!, puts astring => "bbb")
* (class) prev_char/pred_char: returns the previous character, with a changed flag and carry flag; that is, there are three returned values, a string and two booleans.
* split_tab: splits the string into an array at each embedded tab ("Last\tFirst\tMiddle" => ["last","first","middle"])

== Changes

- 1.6.4 Bug fixes: String characters and YAML test files
- 1.6.2 Improve organizaiton of class files to lib/ramp
- 1.6.0 Upgraded to work with Ruby 1.9.1
- 1.5.0 Combined all Ruby extension files into one gem
- 1.0.0 Original

=end


%w{array date enumerable hash kernel nil numeric object process string time yaml}.map{|x|
  require File.dirname(__FILE__) + "/ramp/#{x}.rb"
}
