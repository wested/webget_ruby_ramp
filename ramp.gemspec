Gem::Specification.new do |s|

  s.name              = "ramp"
  s.summary           = "ramp"
  s.version           = "1.0.0"
  s.author            = "WebGet"
  s.email             = "webget@webget.com"
  s.homepage          = "http://webget.com/gems/ramp"
  s.signing_key       = '/home/webget/keys/certs/webget.com.rsa.private.key.and.certificate.pem'
  s.cert_chain        = ['/home/webget/keys/certs/webget.pem']

  s.platform          = Gem::Platform::RUBY
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.files             = ['lib/ramp.rb']
  s.test_files        = ['test/unit/ramp_test.rb']

  #s.add_dependency('foo', '>=0.0.0')

end
