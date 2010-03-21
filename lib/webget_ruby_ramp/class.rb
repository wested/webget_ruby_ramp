# -*- encoding: utf-8 -*-

# Class extensions


class Class

  # Make all the methods public for a block.
  #
  # This is especially useful for unit testing
  # a class's private and protected methods
  #
  # From http://blog.jayfields.com/2007/11/ruby-testing-private-methods.html
  #
  # @example
  #   MyClass.publicize_methods do
  #     ...call some method that was private or protected...
  #   end
  #
  # @return void
 
  def publicize_methods
    saved_private_instance_methods = self.private_instance_methods
    saved_protected_instance_methods = self.protected_instance_methods
    self.class_eval {
      public *saved_private_instance_methods 
      public *saved_protected_instance_methods 
    }
    yield
    self.class_eval {
      private *saved_private_instance_methods 
      protected *saved_protected_instance_methods 
    }
  end

end


