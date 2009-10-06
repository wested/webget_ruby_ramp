
=begin rdoc

= WebGet.com Ramp: methods to ramp up your Ruby On Rails applications

Ramp is a library of extensions to Ruby and Rails base classes, including ActiveRecord, Array, Date, Enumerable, Hash, Kernel, Numeric, Object, Process, String, Time, and YAML. 


Testing: 
<ul>
<li>Each has an associated test class, e.g., ArrayTest, DateTest, etc.
<li>The easy way to run the tests: gem install ramp --test
<li>Some of the ActiveRecord extensions use sqlite for testing. We don't install sqlite automatically because it requires some native extensions. If you need sqlite: gem install sqlite3-ruby
</ul>


== ActiveRecord

* create_or_update_by: create a record, or update a record if value passed matches a field (or fields) in the AR object; includes method_missing function to make code more readable. 
* seed: syntactic sugar alias for #create_or_update_by


== ActiveRecord::ConnectionAdapters::SchemaStatements

* add_column_and_index: database migration helper to add a table column and index at the same time.
* remove_column_and_index: database migration helper to add a table column and index at the same time.


== Array

* choice, choices: one or more random elements from an array
* cross: return the cross pairings of an array with another array
* divvy: divides an array, like a pie, into a specified number of slices
* join: same as Array#join with some improvments
* onto: return a hash that maps an array's keys on to another array's values
* rotate: moves the first element of an array to the end
* slices: divides an array into specified number of equal size sub-arrays ([1,2,3,4,5,6]slices(3) => [[1,2],[3,4],[5,6]])
* to_csv: returns a CSV-style string representation of a multi-dimensional array, with each subarray becoming one 'line' in the output; typically for viewing in a spreadsheet such as Excel.
* to_tdf: returns a TDF-style string representation of a multi-dimensional array, with each subarray becoming one 'line' in the output; typically for viewing in a spreadsheet such as Excel.
* union: builds an array containing each of the unique elements of sub-arrays ([[1,2,3,4],[2,3,4,5],[3,4,5,6]].union => [1,2,3,4,5,6])


== CSV

* http_headers: provides web file download headers for text/csv content type and disposition.


== Date

* age_days, age_years
* between: a random date between two specified dates
* to_sql: date as a string formatted as expected for MySQL
* weekday?, weekend?: is date a weekday or on the weekend


== Enumerable

* cartesian_product: return an array of all possible ordered tuples from arrays.
* join: forwards to self.to_a.join
* map_id: returns the id of an Enumerable object; *requires* that the object respond to an 'id' message
* map_to_a, map_to_f, map_to_i, map_to_s, map_to_sym : convert each object to a specific type by calling its respective method to_a, to_i, to_f, to_s, to_sym
* nitems_until, select_until: returns the number of, or an array containing, the leading elements for which block is false or nil.
* nitems_while, select_while: returns the number of items, or an array containing the leading elements, for which block is not false or nil.
* nitems_with_index, select_with_index: calls block with two arguments, the item and its index, for each item in enum. Returns the number of, or an array containing, the leading elements for which block is not false or nil. 
* power_set: return an array with all subsets of the enum's elements


== File

* File.joindir: wrapper for File.join(File.dirname(...),string,...)


== Hash

* size?: return true if hash has any keys
* each_sort: sort the keys then call each
* each_key!: passes each key to a specified block and updates hash in place if the key changes
* each_pair!: passes each key value pair to a specified block and updates the hash in place if the key or value change.
* each_value!: passes each value to a specified block and updates the hash in place if the value changes.
* map_pair: map each key-value pair by calling a a block
* pivot: aggregates subtotals by keys and values, such as a rollup and rolldown 
* to_yaml_sort: returns a YAML object, sorted by field name


== Integer

* maps: syntactic sugar to yield n times to a block, returning an array of any results (e.g. 3.maps{rand} => [0.4351325,0.7778625,0.158613534])


== IO

* readrow: reads a row line as with IO#readline, and return the row split it into fields 
* IO.readrows: reads the entire file specified by name as individual row lines, and returns those rows split into fields, in an array of arrays.


== Kernel

* method_name: 
* method_name_of_caller: returns the name of the method which called the current method, or the Nth parent up the call stack if the optional caller_index parameter is passed.


== Math

* ln(x): natural log of x
* logn(x,b): log of x in base b


== Numeric

* if: returns 0 if the passed flag is any of: nil, false, 0, [], {} and otherwise returns self
* unless: returns 0 unless the passed flag is any of: nil, false, 0, [], {} and otherwise returns self
* peta, tera, giga, mega, kilo, hecto, deka, deci, centi, milli, micro, nano: multiply/divide by powers of ten


== Object

* in?: returns boolean indicating whether the object is a member of the specified array parameter


== Process

Extensions that help debug Ruby programs.

* (class) ps: output of the system 'ps' command, also including aliases, as raw plain text.
* (class) pss: output of the system 'ps' command as a hash with each value set to the right type, e.g., integer, float, etc..


== REXML::Attributes

* hash: flattens the attributes hash set into a more useful ruby hash, e.g. {:height => 100, :width => 400 }


== String

* capitalize_words (alias to titleize/titlecase): ensures the first character of each word is uppercase.
* decrement: decrease the rightmost natural number, defaults to one value lower or by the optional step parameter value.
* increment: increase the rightmost natural number, defaults to one value higher or by the optional step parameter value.
* lorem: return a short random string, good for use in "lorem ipsum" sample text.
* lowcase: translate a string to lowercase, digits and single underscores (e.g. to a method name)
* prev/pred: previous string ("b" => "a", "bbc" => "bbb", "a" => "z", "880" => "879")
* prev!/pred!: updates variable to the previous string in place (astring = "bbc", astring.prev!, puts astring => "bbb")
* (class) prev_char/pred_char: returns the previous character, with a changed flag and carry flag; that is, there are three returned values, a string and two booleans.
* split_tab: splits the string into an array at each embedded tab ("Last\tFirst\tMiddle" => ["last","first","middle"])
* to_class: the global class reference of a given string
* words: splits the string into an array of words


== Symbol

* <=> and include the comparable mixin to compare symbols as strings


== Time

* (class) stamp: current time in UTC as a timestamp string ("YYYYMMDDHHMMSS")
* to_sql: time as a string formatted as expected for MySQL


== XML

* (class) load_dir: specify a one or more directory patterns and pass each XML file in the matching directories to a block; see [Dir#glob](http://www.ruby-doc.org/core/classes/Dir.html#M002347) for pattern details.


== YAML

* (class) load_dir: specify a one or more directory patterns and pass each YAML file in the matching directories to a block; see [Dir#glob](http://www.ruby-doc.org/core/classes/Dir.html#M002347) for pattern details.


== Changes

- 1.7.0.2 Add Array#to_tdf
- 1.7.0.1 Remove sqlite3 testing dependency
- 1.6.9.6 Add Symbol with comparable and <=>
- 1.6.9.5 Add ActiveRecord testing with sqlite3
- 1.6.9.4 JRuby install and test successful
- 1.6.9.3 Array#join add infix, prefix, suffix
- 1.6.9.2 Improve ri docs
- 1.6.9.1 Add Array#onto, Enumerable#intersect?
- 1.6.9.0 Add IO, File, ActiveRecord#seed
- 1.6.8.9 Add Enumerable#to_h, Array#hash, Hash#each_key!, Hash#each_pair, Hash#each_value!
- 1.6.8.8 Add Hash#map_pair, Hash#size?, Hash#pivot
- 1.6.8.7 Add Math
- 1.6.8.6 Add ActiveRecord SchemaStatements
- 1.6.8.5 Add Integer#maps, String#ACCENTS
- 1.6.8.4 Add XML
- 1.6.8.3 Add ActiveRecord
- 1.6.8.2 Add String#lowcase
- 1.6.8 Add map_to_xxx methods
- 1.6.7 Add CSV
- 1.6.6 Add Array#to_csv, Integer, String#lorem, etc., improve tests
- 1.6.4 Bug fixes: String characters and YAML test files
- 1.6.2 Improve organizaiton of class files to lib/ramp
- 1.6.0 Upgraded to work with Ruby 1.9.1
- 1.5.0 Combined all Ruby extension files into one gem
- 1.0.0 Original 

=end

%w{active_record array csv date enumerable file hash integer io kernel math nil numeric object process string symbol time xml yaml}.map{|x|
  require File.dirname(__FILE__) + "/ramp/#{x}.rb"
}


