# -*- encoding: utf-8 -*-

# Time extensions

class Time


  # @return [String] a time stamp string in standard format: "YYYY-MM-DD HH:MM:SSZ"
  #
  # This standard format is specified in IETF RFC 3339 and ISO 8601.
  #
  # @see http://www.ietf.org/rfc/rfc3339.txt
  #
  # @example
  #   Time.now.stamp 
  #   => "2010-12-31 12:59:59Z" 

  def stamp
    getutc.strftime('%Y-%m-%d %H:%M:%SZ')
  end


  # Shorthand for Time.now.stamp
  #
  # @example
  #   Time.stamp
  #    => "2010-12-31 12:59:59Z" 
  #
  # @return [String] Time.now.stamp

  def self.stamp
    now.stamp
  end


  # @return [String] time packed into a short string: "YYYYMMDDHHMMSS"
  #
  # The time is converted to UTC.
  #
  # @example
  #   Time.now.pack
  #   => "20101231125959" 

  def pack
    getutc.strftime('%Y%m%d%H%M%S')
  end


  # Shorthand for Time.now.pack
  #
  # @example
  #   Time.pack
  #   => "20101231125959" 
  # 
  # @return [String] Time.now.pack                                                                                 

  def self.pack
    now.pack
  end

end
