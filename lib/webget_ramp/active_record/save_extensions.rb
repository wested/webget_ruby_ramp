module ActiveRecord::SaveExtensions

  # Save the record without validation, then reload it.
  # If the record is valid then return true, otherwise raise RecordInvalid.
  # This solves an issue we found with Rails associations not saving.
  #
  # By Andrew Carpenter (acarpen@wested.org)
  #
  # Deprecated, superceded by #save_redux!

  def save_false_then_reload!
    transaction do
      save(false)
      reload
      valid? or raise ActiveRecord::RecordInvalid.new(self)
    end
    return true
  end


  # Save the record without validation, then reload, then save with validtion.
  # This ensure that rails brings back the correct associations to validate.
  # This solves an issue we found with Rails associations not saving.

  def save_redux!
    transaction do
      save(false)
      reload
      save!
    end
    return true
  end

end
ActiveRecord::Base.send(:include, ActiveRecord::SaveExtensions)
