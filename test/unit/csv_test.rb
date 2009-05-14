require 'test/unit'
require 'ramp'

class CSVTest < Test::Unit::TestCase

 def test_http_headers
   h=CSV::HTTP.headers
   assert_equal(h["Content-Type"],'text/csv')
   assert_equal(h["Content-Disposition"],"attachment; filename=\"data.csv\"")
 end

 def test_http_headers_with_filename
   h=CSV::HTTP.headers(filename=>'foo')
   assert_equal(h["Content-Type"],'text/csv')
   assert_equal(h["Content-Disposition"],"attachment; filename=\"foo\"")
 end

end
