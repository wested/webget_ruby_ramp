require 'test/unit'

['array','class','csv','date','enumerable','file','hash','integer','io','kernel','math','nil','numeric','object','process','string','symbol','time','xml','yaml'].map{|x|
  require File.dirname(__FILE__) + "/webget_ruby_ramp/#{x}_test.rb"
}

