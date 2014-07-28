# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snapshotar/version'

Gem::Specification.new do |spec|
  spec.name          = "snapshotar"
  spec.version       = Snapshotar::VERSION
  spec.authors       = ["Benjamin Müller"]
  spec.email         = ["benjamin@boxar.de"]
  spec.description   = %q{Make a snapshot of your rails database by serializing all objects.}
  spec.summary       = %q{In contrast to a database backup, snapshotAR is able to manage image references made with paperclip or carrierwave correctly. You are able to save your entire application or only parts of it and e.g. seed your test environments. }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency 'mongoid', '~> 4.0.0'
  spec.add_development_dependency 'carrierwave-mongoid'

  spec.add_dependency 'aws-sdk', '~> 1.0'
  spec.add_dependency 'jbuilder'
end
