require 'test/unit'
require 'webget_ruby_ramp'

class CSVTest < Test::Unit::TestCase

  def test_http_headers
    h=CSV.http_headers
    assert_equal('text/csv',h["Content-Type"])
    assert_equal("attachment; filename=\"data.csv\"",h["Content-Disposition"])
  end

  def test_http_headers_with_filename
    h=CSV.http_headers(:filename=>'foo')
    assert_equal('text/csv',h["Content-Type"])
    assert_equal("attachment; filename=\"foo\"",h["Content-Disposition"])
  end

 def test_http_headers_adjust_for_broken_msie_with_request_as_firefox
   headers = {:request => MockRequest.new('HTTP_USER_AGENT' => 'firefox')}
   headers = CSV.http_headers_adjust_for_broken_msie(headers)
   assert_equal(nil,headers[:content_type])
   assert_equal(nil,headers[:cache])
 end

 def test_http_headers_adjust_for_broken_msie_with_request_as_msie
   headers = {:request => MockRequest.new('HTTP_USER_AGENT' => 'msie')}
   headers = CSV.http_headers_adjust_for_broken_msie(headers)
   assert_equal('text/plain',headers[:content_type])
   assert_equal(false,headers[:cache])
 end

end

class MockRequest

  def initialize(env)
    @env=env
  end

  def env
    @env
  end
       
end
 
