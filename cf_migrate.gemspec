# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cf_migrate/version'

Gem::Specification.new do |spec|
  spec.name          = "cf_migrate"
  spec.version       = CfMigrate::VERSION
  spec.authors       = ["tcain"]
  spec.email         = ["tcain@weblinc.com"]
  spec.description   = %q{Cf migrate tool}
  spec.summary       = %q{Assists in building migrations on coldfusion projects}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "httparty", "0.9.0"
end
