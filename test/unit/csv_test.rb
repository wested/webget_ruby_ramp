require 'test/unit'
require 'ramp'

class CSVTest < Test::Unit::TestCase

 def test_http_headers
   h=CSV.http_headers
   assert_equal('text/csv',h["Content-Type"])
   assert_equal("attachment; filename=\"data.csv\""),h["Content-Disposition"])
 end

 def test_http_headers_with_filename
   h=CSV.http_headers(filename=>'foo')
   assert_equal('text/csv',h["Content-Type"])
   assert_equal("attachment; filename=\"foo\"",h["Content-Disposition"])
 end

end
