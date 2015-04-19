# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fx_rates/version'

Gem::Specification.new do |spec|
  spec.name          = "fx-rates"
  spec.version       = FxRates::VERSION
  spec.authors       = ["Phil McClure"]
  spec.email         = ["pmcclure@rumblelabs.com"]
  spec.summary       = %q{Currency conversion library}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6.6"
  spec.add_dependency "moneta", "~> 0.8.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
