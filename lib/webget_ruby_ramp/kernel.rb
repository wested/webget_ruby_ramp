# -*- encoding: utf-8 -*-

require 'pp'
require 'stringio'  

# Kernel extensions

module Kernel

  # See:
  # - http://www.ruby-forum.com/topic/75258
  # - In 1.9 (Ruby CVS HEAD) there is #__method__ and #__callee__
  # - http://eigenclass.org/hiki.rb?Changes+in+Ruby+1.9#l90
  #-
  # Make this fast because its often doing logging & reporting.
  # Inline this and use $1 because it's empirically faster than /1
  #
  # These two methods are always equal:
  #   caller_method_name(0) === my_method_name
  #
  # @example
  #   def foo
  #     puts my_method_name
  #   end
  #   foo
  #   => "foo"
  #
  # @return [String] my method name

  def my_method_name
    caller[0] =~ /`([^']*)'/ and $1
  end


  # See:
  # - http://www.ruby-forum.com/topic/75258
  # - In 1.9 (Ruby CVS HEAD) there is #__method__ and #__callee__
  # - http://eigenclass.org/hiki.rb?Changes+in+Ruby+1.9#l90
  #-
  # Make this fast because its often doing logging & reporting.
  # Inline this and use $1 because it's empirically faster than /1
  #
  # These two methods are always equal:
  #   caller_method_name(0) === my_method_name
  #
  # @example
  #   def foo
  #     puts caller_method_name(0)
  #     puts caller_method_name(1)
  #   end
  #   => 
  #   "foo"
  #   "irb_binding"
  #
  # @return [String] the method name of the caller at the index

  def caller_method_name(caller_index=0)
    caller[caller_index] =~ /`([^']*)'/ and $1
  end

  
  # Pretty print to a string.
  # 
  # Created by Graeme Mathieson.
  #
  # See http://rha7dotcom.blogspot.com/2008/07/ruby-and-rails-how-to-get-pp-pretty.html
  #
  # @example
  #   pp_s(["foo","goo"])
  #   => "[\"foo\", \"goo\"]\n"
  #
  # @return [String] a pretty print string of the params

  def pp_s(*objs)  
    str = StringIO.new  
    objs.each {|obj|  
        PP.pp(obj, str)  
      }  
      str.rewind  
      str.read  
  end  
  module_function :pp_s  

end

