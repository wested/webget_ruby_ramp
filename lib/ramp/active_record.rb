
# create_or_update
# create_or_update_by_xxx
# See http://www.intridea.com/2008/2/19/activerecord-base-create_or_update-on-steroids-2?blog=company

class << ActiveRecord::Base

  # See http://www.intridea.com/2008/2/19/activerecord-base-create_or_update-on-steroids-2?blog=company

  def create_or_update(options = {})
    self.create_or_update_by(:id, options)
  end


  # See http://www.intridea.com/2008/2/19/activerecord-base-create_or_update-on-steroids-2?blog=company

  def create_or_update_by(field, options = {})
    find_value = options.delete(field)
    record = find(:first, :conditions => {field => find_value}) || self.new
    record.send field.to_s + '=', find_value
    options.each_pair do |key, value| record.send key.to_s + '=', value
    end
    record.attributes = options
    record.save!
    record
  end


  # See http://www.intridea.com/2008/2/19/activerecord-base-create_or_update-on-steroids-2?blog=company

  def method_missing_with_create_or_update(method_name, *args)
    if match = method_name.to_s.match(/create_or_update_by_([a-z0-9_]+)/)
      field = match[1].to_sym
      create_or_update_by(field,*args)
    else
      method_missing_without_create_or_update(method_name, *args)
    end
  end

  alias_method_chain :method_missing, :create_or_update

end
