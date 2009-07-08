module Math


  # Returns the natural log of x 

  def Math.ln(x)
   Math.log(x)
  end


  # Returns the log of x in base b.
 
  def Math.logn(x,b)
    Math.ln(x)/Math.ln(b)
  end


end
