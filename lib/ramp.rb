%w{array date enumerable hash kernel nil numeric object process string time yaml}.map{|x|
  require File.dirname(__FILE__) + "/ramp/#{x}.rb"
}
