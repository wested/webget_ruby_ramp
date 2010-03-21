# -*- encoding: utf-8 -*-

# Symbol extensions

class Symbol

  # Compare this symbol to another symbol.
  # 
  # @example Less than
  #    :foo <=> :goo 
  #    => -1
  #
  # @example Equal
  #    :foo <=> :foo
  #    => 0
  #
  # @example Greater than
  #    :foo <=> :bar 
  #    => 1
  #
  # @return [-1,0,1] -1 if this is < that, 0

  include Comparable
  def <=>(that)
    self.to_s<=>that.to_s
  end

end

