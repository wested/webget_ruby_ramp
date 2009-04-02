class Numeric


 # Return 0 if the given flag is any of: nil, false, 0, [], {}
 #
 # This is useful for multiplying a number if and only if a flag is set.
 #
 # ==Example
 #   sum = x.if(foo) + y.if(bar)

 def if(flag)
  (flag==nil or flag==false or flag==0 or flag==[] or flag=={}) ? 0 : self
 end


 # Return self if flag is nil, false, 0, [], {}; otherwise return 0.
 #
 # This is useful for multiplying a number if and only if a flag is unset.
 #
 # ==Example
 #   sum = w.if_not(foo) +y.if_not(bar)

 def if_not(flag)
  (flag==nil or flag==false or flag==0 or flag==[] or flag=={}) ? self : 0
 end


end
