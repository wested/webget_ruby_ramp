Gem::Specification.new do |s|

  CLASSES             = %w'array date enumerable hash kernel nil numeric object process string time yaml'

  s.name              = "ramp"
  s.summary           = "ramp"
  s.version           = "1.6.5"
  s.author            = "WebGet"
  s.email             = "webget@webget.com"
  s.homepage          = "http://webget.com/gems/ramp"
  s.signing_key       = '/home/webget/keys/certs/webget.com.rsa.private.key.and.certificate.pem'
  s.cert_chain        = ['/home/webget/keys/certs/webget.pem']

  s.platform          = Gem::Platform::RUBY
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.files             = ['lib/ramp.rb'] + CLASSES.map{|c| "lib/ramp/#{c}.rb"} + ['test/unit/yaml_test_1.yml','test/unit/yaml_test_2.yml']
  s.test_files        = CLASSES.map{|c| "test/unit/#{c}_test.rb"}


end
