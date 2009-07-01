module Math

  module_function

  # Returns the natural log of x 

  def ln(x)
   Math.log(x)
  end


  # Returns the log of x in base b.
 
  def logn(x,b)
    Math.ln(x)/Math.ln(b)
  end


end
