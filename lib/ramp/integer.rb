class Integer

  # Return an array of _self_ calls to yield
  #
  # Examples
  #   3.yields{rand} => [0.0248131784304143, 0.814666170190905, 0.15812816258206]

  def yields
    (1..self).map{yield}
  end

end
