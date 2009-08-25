require 'activerecord'
require 'active_record'

# ActiveRecord extensions

class << ActiveRecord::Base #:doc:

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
  # Example:
  # { "admin"     => ["Administrator", 1000], 
  #   "member"    => ["Member", 1], 
  #   "moderator" => ["Moderator", 100],
  #   "disabled"  => ["Disabled User", -1] }.each_pair do |key, val|
  #     Role.create_or_update_by_key(:key => key, :name => val[0], :value => val[1])
  # end

  def create_or_update(options = {})  #:doc:
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

  def create_or_update_by(condition_keys, attribute_pairs = {})  #:doc:
    condition_pairs=[*condition_keys].map{|x| [x,(attribute_pairs.delete(x)||attribute_pairs.delete(x.to_s)||attribute_pairs.delete(x.to_sym))]}.to_h
    record = find(:first, :conditions => condition_pairs) || self.new
    if record.new_record? then attribute_pairs.merge!(condition_pairs) end
    attribute_pairs.each_pair{|k,v| record.send k.to_s+'=', v}
    record.save!
    return record
  end


  # Syntactic sugar for setting up a database with initial data, e.g. in rake db:seed
  alias :seed :create_or_update_by  #:doc:


  def method_missing_with_create_or_update(method_name, *args)  #:doc:
    if match = method_name.to_s.match(/create_or_update_by_([a-z0-9_]+)/)  
      field = match[1]
      return create_or_update_by(field,*args)
    end
    return method_missing_without_create_or_update(method_name, *args)
  end

  alias_method_chain :method_missing, :create_or_update  #:doc:

end
