# = WebGet.com Ruby Time class extensions 
#
# Author:: Joel Parker Henderson, joelparkerhenderson@gmail.com
# Copyright:: Copyright (c) 2006-2009 Joel Parker Henderson
# License:: CreativeCommons License, Non-commercial Share Alike
# License:: LGPL, GNU Lesser General Public License
#
#
# ==Example
#
#   Time.stamp
#   => "20080504125959"
##

class Time

  # Return current time in UTC as a timestamp string "YYYYMMDDHHMMSS"
  def self.stamp
    now.utc.strftime('%Y%m%d%H%M%S')
  end

end
