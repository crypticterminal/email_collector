# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_collectoR/version'

Gem::Specification.new do |gem|
  gem.name          = 'email_collector'
  gem.version       = EmailCollector::VERSION
  gem.authors       = ['Alexei Fedotov']
  gem.email         = ['alexei.fedotov@gmail.com']
  gem.description   = %q{Collects emails from Google}
  gem.summary       = %q{Sends search requests to Google and parses responses for emails}
  gem.homepage      = 'http://www.dataved.ru/2010/09/add-your-friends-to-google.html'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = []
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib'] 
  gem.license = 'Apache'
end
