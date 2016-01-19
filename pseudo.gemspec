# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pseudo/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'codeclimate-test-reporter', '0.4.8'
  spec.add_development_dependency 'minitest', '5.8.3'
  spec.add_development_dependency 'rake', '10.4.2'
  spec.authors = ['Nate Smith']
  spec.description = 'Pseudo supports stubs and spy-style message expectations.'
  spec.email = ['nwjsmith@gmail.com']
  spec.files = Dir.glob('lib/**/*.rb')
  spec.homepage = 'https://github.com/nwjsmith/pseudo'
  spec.license = 'MIT'
  spec.name = 'pseudo'
  spec.require_paths = ['lib']
  spec.require_ruby_version = '>= 1.9.3'
  spec.summary = "A mocking library that doesn't support bad tests."
  spec.test_files = Dir.glob('test/**/*.rb')
  spec.version = Pseudo::VERSION
end
