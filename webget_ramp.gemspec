Gem::Specification.new do |s|

  CLASSES             = %w'active_record active_record/connection_adapters/abstract/schema_statements array csv date enumerable file hash integer io kernel math nil numeric object process string symbol time xml yaml'
  TEST_FILES          = %w'io_test.txt xml_test_msword_clean.html xml_test_msword_dirty.html xml_test_1.xml xml_test_2.xml yaml_test_1.yml yaml_test_2.yml'

  s.name              = "webget_ramp"
  s.summary           = "WebGet ramp gem provides base extensions to ruby classes and rails classes."
  s.version           = "1.7.1.3"
  s.author            = "WebGet"
  s.email             = "webget@webget.com"
  s.homepage          = "http://webget.com/ruby/gem/webget_ramp"
  s.signing_key       = '/home/webget/keys/certs/webget.com.rsa.private.key.and.certificate.pem'
  s.cert_chain        = ['/home/webget/keys/certs/webget.pem']

  s.platform          = Gem::Platform::RUBY
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.files             = ['lib/webget_ramp.rb'] + CLASSES.map{|c| "lib/webget_ramp/#{c}.rb"} + TEST_FILES.map{|f| "test/webget_ramp/#{f}"}
  s.test_files        = CLASSES.map{|c| "test/webget_ramp/#{c}_test.rb"}

  #s.add_dependency('sqlite3-ruby') # for testing ActiveRecord

end
