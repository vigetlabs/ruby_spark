# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_spark/version'
require 'ruby_spark/client'

Gem::Specification.new do |spec|
  spec.name          = "ruby_spark"
  spec.version       = RubySpark::VERSION
  spec.authors       = ["Eli Fatsi"]
  spec.email         = ["eli.fatsi@viget.com"]
  spec.description   = "Ruby Gem to make API calls to the Spark Cloud"
  spec.summary       = "Ruby Gem to make API calls to the Spark Cloud"
  spec.homepage      = "http://github.com/efatsi/ruby_spark"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/) + Dir['lib/*/*']
  spec.test_files    = spec.files.grep(%r{^spec/})

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "httparty"
end
