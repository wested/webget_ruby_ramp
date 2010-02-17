require 'activerecord'
require 'active_record'

#:startdoc:
# ActiveRecord extensions

module ActiveRecord #:doc:

class Base #:doc:

  # Create a record, or update a record if value passed matches a field in the AR object;
  # includes method_missing function to make code more readable
  #
  # Most common use will be for testing (fixture/mock object generation)
  #
  # Three versions of method included:
  # create_or_update
  # create_or_update_by
  # create_or_update_by_xxx (where xxx is a field name)
  #
  # Inspired by http://www.intridea.com/2008/2/19/activerecord-base-create_or_update-on-steroids-2
  #
  # ==Example
  # { "admin"     => ["Administrator", 1000], 
  #   "member"    => ["Member", 1], 
  #   "moderator" => ["Moderator", 100],
  #   "disabled"  => ["Disabled User", -1] }.each_pair do |key, val|
  #     Role.create_or_update_by_key(:key => key, :name => val[0], :value => val[1])
  # end

  def self.create_or_update(options = {})
    self.create_or_update_by(:id, options)
  end


  # Create or update a record by field (or fields).
  # This will look for each field name as a key in the options hash.
  #
  # ==Example
  #   attributes={:name="John Smith", :email=>"john@example.com", :birthdate=>'1980/01/01'}
  #   User.create_or_update_by(:email,attributes)
  #   => if a user with that email exists then update his name and birthdate, else create him
  #
  # ==Example with multiple conditions
  #   attributes={:name="John Smith", :email=>"john@example.com", :birthdate=>'1980/01/01'}
  #   User.create_or_update_by([:name,:birthdate],attributes)
  #   => if a user with that name and birthdate exists then update his email, else create him
  #
  # The fields can be any mix of symbols or strings.
  # The option keys can be any mix of symbols or strings.

  def self.create_or_update_by(condition_keys, attribute_pairs = {})
    condition_pairs=[*condition_keys].map{|key| [key,(attribute_pairs.delete(key)||attribute_pairs.delete(key.to_s)||attribute_pairs.delete(key.to_sym))]}.to_h
    record = find(:first, :conditions => condition_pairs) || self.new
    if record.new_record? then attribute_pairs.merge!(condition_pairs) end
    attribute_pairs.each_pair{|key,val| record.send key.to_s+'=', val}
    record.save!
    return record
  end


  # Set up a database with initial data, e.g. in rake db:seed method.
  #
  # This will look for each field name as a key in the options hash.
  #
  # This method calls #create_or_update_by (and you may want to change
  # this behavior to do more, e.g. to test that a DB and table exists).
  #
  # ==Example
  #   attributes={:name="John Smith", :email=>"john@example.com", :birthdate=>'1980/01/01'}
  #   User.create_or_update_by(:email,attributes)
  #   => if a user with that email exists then update his name and birthdate, else create him
  #
  # ==Example with multiple conditions
  #   attributes={:name="John Smith", :email=>"john@example.com", :birthdate=>'1980/01/01'}
  #   User.create_or_update_by([:name,:birthdate],attributes)
  #   => if a user with that name and birthdate exists then update his email, else create him
  #
  # The fields can be any mix of symbols or strings.
  # The option keys can be any mix of symbols or strings.

  def self.seed(condition_keys, attribute_pairs = {})
    self.create_or_update_by(condition_keys, attribute_pairs)
  end


  # Method missing for create_or_update_by_xxx that forwards to #create_or_update_by
  #
  # ==Example
  #   MyModel.create_or_update_by_foo(options)
  #   => MyModel.create_or_update_by(:foo,option)

  def self.method_missing_with_create_or_update(method_name, *args) 
    if match = method_name.to_s.match(/create_or_update_by_([a-z0-9_]+)/)  
      field = match[1]
      return create_or_update_by(field,*args)
    end
    return method_missing_without_create_or_update(method_name, *args)
  end


  # For alias method chain
  def self.included(base)
    # base == ActiveRecord::Base (the class)
    base.class_eval do
        # class_eval makes self == ActiveRecord::Base, and makes def define instance methods.
        extend ClassMethods
        # If has_many were an instance method, we could do this
        #   alias_method_chain :has_many, :association_option; end            
        # but it's a class method, so we have to do the alias_method_chain on  
        # the meta-class for ActiveRecord::Base, which is what class << self does.   
        class << self;  alias_method_chain :method_missing, :create_or_update;  end
      end
  end


end

end
