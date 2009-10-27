# -*- coding: utf-8 -*-
class Symbol

  include Comparable
  def <=>(that)
    self.to_s<=>that.to_s
  end

end

