class Time

  # Return current time in UTC as a timestamp string "YYYYMMDDHHMMSS"

  def self.stamp
    now.utc.strftime('%Y%m%d%H%M%S')
  end

end
