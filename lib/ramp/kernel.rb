module Kernel

  # See:
  # - http://www.ruby-forum.com/topic/75258
  # - In 1.9 (Ruby CVS HEAD) there is #__method__ and #__callee__
  # - http://eigenclass.org/hiki.rb?Changes+in+Ruby+1.9#l90

  def method_name(caller_index=0)
    # Make this fast because its often doing logging & reporting.
    # Inline this and use $1 because it's empirically faster than /1
    caller[caller_index] =~ /`([^']*)'/ and $1
  end

end

