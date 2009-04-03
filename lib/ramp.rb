# = WebGet.com Ramp: methods to ramp up your ruby applications
#
# Ramp is a library of simple straightforward Ruby base class extensions.
# 
# == Changes
# - 1.6.4 Bug fixes: String characters and YAML test files
# - 1.6.2 Improve organizaiton of class files to lib/ramp
# - 1.6.0 Upgraded to work with Ruby 1.9.1
# - 1.5.0 Combined all Ruby extension files into one gem
# - 1.0.0 Original




%w{array date enumerable hash kernel nil numeric object process string time yaml}.map{|x|
  require File.dirname(__FILE__) + "/ramp/#{x}.rb"
}
