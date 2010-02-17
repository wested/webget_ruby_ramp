# Numeric extensions

class Numeric


 # Return 0 if the given flag is any of: nil, false, 0, [], {}
 #
 # ==Example
 #   3.if(true) => 3
 #   3.if(false) => 0
 #   

 def if(flag)
   # inline for speed
   return (flag==nil or flag==false or flag==0 or flag==[] or flag=={}) ? 0 : self
 end


 # Return self if flag is nil, false, 0, [], {}; otherwise return 0.
 #
 # ==Example
 #   3.unless(true) => 0
 #   3.unless(false) => 3

 def unless(flag)
   # inline for speed
   return (flag==nil or flag==false or flag==0 or flag==[] or flag=={}) ? self : 0
 end


 ###
 #
 #  Metric conversions
 #
 ###

 # Return self / 10^15
 def peta
  self/1000000000000000
 end

 # Return self / 10^12
 def tera
  self/1000000000000
 end

 # Return self / 10^9
 def giga
  self/1000000000
 end

 # Return self / 10^6
 def mega
  self/100000
 end

 # Return self / 10^3
 def kilo
  self/1000
 end

 # Return self / 10^2
 def hecto
  self/100
 end

 # Return self / 10
 def deka
  self/10
 end
 
 # Return self * 10
 def deci
  self*10
 end

 # Return self * 10^2
 def centi
  self*100
 end

 # Return self * 10^3
 def milli
  self*1000
 end

 # Return self * 10^6
 def micro
  self*1000000
 end

 # Return self * 10^9
 def nano
  self*1000000000
 end


end
