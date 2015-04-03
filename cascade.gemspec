# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cascade/version'

Gem::Specification.new do |spec|
  spec.name          = "cascade"
  spec.version       = Cascade::VERSION
  spec.authors       = ["Ignat Zakrevsky"]
  spec.email         = %w(iezakrevsky@gmail.com)
  spec.summary       = %q{Ruby data parser gem.}
  spec.description   = %q{Highly customizable ruby parser with a lot of DI}
  spec.homepage      = "https://github.com/ignat-zakrevsky/cascade"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "iso_country_codes"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rr"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "codeclimate-test-reporter"
end
