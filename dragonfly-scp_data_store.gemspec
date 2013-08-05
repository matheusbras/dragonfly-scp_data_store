# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragonfly/scp_data_store/version'

Gem::Specification.new do |spec|
  spec.name          = "dragonfly-scp_data_store"
  spec.version       = Dragonfly::ScpDataStore::VERSION
  spec.authors       = ["Matheus Bras", "Thiago Belem"]
  spec.email         = ["bras.matheus@gmail.com", "contato@thiagobelem.net"]
  spec.description   = %q{A dragonfly datastore adapter for saving your images on remote stores using scp and ssh.}
  spec.summary       = %q{A dragonfly datastore adapter}
  spec.homepage      = "http://github.com/matheusbras/dragonfly-scp_data_store"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "dragonfly", '>= 0.9'
  spec.add_dependency 'net-ssh', '2.6.8'
  spec.add_dependency 'net-scp', '1.1.2'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", '>= 2.6.0'
end
