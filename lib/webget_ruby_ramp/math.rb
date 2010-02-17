# Math extensions

module Math


  # Return the natural log of _num_

  def Math.ln(num)
   Math.log(num)
  end


  # Return the log of _num_ in base _base_
 
  def Math.logn(num,base)
    Math.ln(num)/Math.ln(base)
  end


end
