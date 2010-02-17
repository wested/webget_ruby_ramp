# NilClass provides an instantiatable object
# suitable for more careful thorough programming.

class NilClass

 # Same as Rails
 def blank?
  return true
 end

 # Return false
 def size?
  return false
 end

end

