Gem::Specification.new do |s|

  CLASSES             = %w'active_record array csv date enumerable hash integer kernel nil numeric object process string time xml yaml'
  TEST_UNIT_FILES     = %w'xml_test_1.xml xml_test_2.xml yaml_test_1.yml yaml_test_2.yml'

  s.name              = "ramp"
  s.summary           = "ramp"
  s.version           = "1.6.8.5"
  s.author            = "WebGet"
  s.email             = "webget@webget.com"
  s.homepage          = "http://webget.com/gems/ramp"
  s.signing_key       = '/home/webget/keys/certs/webget.com.rsa.private.key.and.certificate.pem'
  s.cert_chain        = ['/home/webget/keys/certs/webget.pem']

  s.platform          = Gem::Platform::RUBY
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.files             = ['lib/ramp.rb'] + CLASSES.map{|c| "lib/ramp/#{c}.rb"} + TEST_UNIT_FILES.map{|f| "test/unit/#{f}"}
  s.test_files        = CLASSES.map{|c| "test/unit/#{c}_test.rb"}


end
