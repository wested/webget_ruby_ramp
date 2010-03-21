# -*- encoding: utf-8 -*-

# Math extensions

module Math


  # @return [Float] the natural log of _num_
  #
  # @example
  #   Math.ln(2.719)
  #   => 1.00

  def Math.ln(num)
   Math.log(num)
  end


  # @return [Float] the log of _num_ in base _base_
  #
  # @example
  #   Math.logn(10000,10) 
  #   => 4.00
 
  def Math.logn(num,base)
    Math.ln(num)/Math.ln(base)
  end


end
