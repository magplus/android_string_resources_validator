# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'android_string_resources_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "android_string_resources_validator"
  spec.version       = AndroidStringResourcesValidator::VERSION
  spec.authors       = ["Karl Eklund", "Lennart Fridén"]
  spec.email         = ["backend@magplus.com"]
  spec.summary       = %q{Validates an Android strings.xml file.}
  spec.description   = %q{Validates an Android string resource file against the specification at http://developer.android.com/guide/topics/resources/string-resource.html.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
