Gem::Specification.new do |s|

  CLASSES             = ['array','class','csv','date','enumerable','file','fixnum','hash','integer','io','kernel','math','nil','numeric','object','process','string','symbol','time','xml','yaml']
  TEST_FILES          = ['io_test.txt','xml_test_msword_clean.html','xml_test_msword_dirty.html','xml_test_1.xml','xml_test_2.xml','yaml_test_1.yml','yaml_test_2.yml']

  s.name              = "webget_ruby_ramp"
  s.summary           = "WebGet Ruby Gem: Ramp gem provides base extensions to ruby classes and rails classes."
  s.version           = "1.8.0"
  s.author            = "WebGet"
  s.email             = "webget@webget.com"
  s.homepage          = "http://webget.com/"
  s.signing_key       = '/home/webget/keys/certs/webget.com.rsa.private.key.and.certificate.pem'
  s.cert_chain        = ['/home/webget/keys/certs/webget.pem']

  s.platform          = Gem::Platform::RUBY
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.files             = ['README.rdoc','LICENSE.txt','lib/webget_ruby_ramp.rb'] + CLASSES.map{|c| "lib/webget_ruby_ramp/#{c}.rb"} + TEST_FILES.map{|f| "test/webget_ruby_ramp/#{f}"}
  s.test_files        = CLASSES.map{|c| "test/webget_ruby_ramp/#{c}_test.rb"}

end
