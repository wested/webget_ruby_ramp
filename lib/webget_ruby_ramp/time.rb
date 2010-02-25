# -*- encoding: utf-8 -*-

# Time extensions

class Time


  # Return a time stamp string in standard format: "YYYY-MM-DD HH:MM:SSZ"
  #
  # This standard format is specified in IETF RFC 3339 and ISO 8601.
  #
  # See http://www.ietf.org/rfc/rfc3339.txt
  #
  # ==Example
  #   Time.now.stamp => "2010-12-31 12:59:59Z" 

  def stamp
    getutc.strftime('%Y-%m-%d %H:%M:%SZ')
  end


  # Shorthand for Time.now.stamp
  #
  # ==Example
  #   Time.stamp => "2010-12-31 12:59:59Z" 

  def self.stamp
    now.stamp
  end


  # Return time packed into a short string: "YYYYMMDDHHMMSS"
  #
  # The time is converted to UTC.
  #
  # ==Example
  #   Time.now.pack => "20101231125959" 

  def pack
    getutc.strftime('%Y%m%d%H%M%S')
  end


  # Shorthand for Time.now.pack
  #
  # ==Example
  #   Time.pack => "20101231125959" 

  def self.pack
    now.pack
  end

end
