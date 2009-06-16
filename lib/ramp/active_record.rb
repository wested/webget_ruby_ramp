
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

require 'activerecord'
require 'active_record'

class << ActiveRecord::Base  

  def create_or_update(options = {})
    self.create_or_update_by(:id, options)
  end

  # Create or update a record by a field.
  # This will look for the field as a key for the options.
  #
  # The field can be a symbol or string.
  # The option keys can be any mix of symbols or strings.

  def create_or_update_by(field, options = {})
    field_s=field.to_s
    field_sym=field.to_sym
    find_value = options.delete(field)||options.delete(field_s)||options.delete(field_sym)
    record = find(:first, :conditions => {field_sym => find_value}) || self.new
    if record.new_record? then record.send field_s + '=', find_value end
    options.each_pair{|key, value| record.send key.to_s + '=', value}
    record.save!
    record
  end

  def method_missing_with_create_or_update(method_name, *args)
    if match = method_name.to_s.match(/create_or_update_by_([a-z0-9_]+)/)  
      field = match[1]
      return create_or_update_by(field,*args)
    end
    method_missing_without_create_or_update(method_name, *args)
  end

  alias_method_chain :method_missing, :create_or_update

end
