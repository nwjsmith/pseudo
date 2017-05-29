lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pseudo/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'codeclimate-test-reporter', '0.6.0'
  spec.add_development_dependency 'minitest', '5.9.0'
  spec.add_development_dependency 'rake', '11.2.2'
  spec.authors = ['Nate Smith']
  spec.description = 'Pseudo supports stubs and spy-style message expectations.'
  spec.email = ['nwjsmith@gmail.com']
  spec.files = Dir.glob('lib/**/*.rb')
  spec.homepage = 'https://github.com/nwjsmith/pseudo'
  spec.license = 'MIT'
  spec.name = 'pseudo'
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0.0'
  spec.summary = "A mocking library that doesn't support bad tests."
  spec.test_files = Dir.glob('test/**/*.rb')
  spec.version = Pseudo::VERSION
end
