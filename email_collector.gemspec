# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'email_collector'
  gem.version       = '0.3.0'
  gem.authors       = ['Alexei Fedotov']
  gem.email         = ['alexei.fedotov@gmail.com']
  gem.description   = %q{Collects emails from Google}
  gem.summary       = %q{Sends search requests to Google and parses responses for emails}
  gem.homepage      = 'https://github.com/leshikus/email_collector'
  
  gem.files         = `git ls-files`.split($/)
  gem.executables   = []
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  
  gem.require_paths = ['lib']
  
  gem.license = 'Apache-2.0'
  
  gem.add_runtime_dependency 'google-search', '1.0.3'
  gem.add_runtime_dependency 'logger', '1.2.8'
  gem.required_ruby_version = '>= 2.0'
end
