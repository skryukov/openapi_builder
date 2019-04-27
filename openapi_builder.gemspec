lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "openapi_builder/version"

Gem::Specification.new do |spec|
  spec.name = "openapi_builder"
  spec.version = OpenapiBuilder::VERSION
  spec.authors = ["Svyatoslav Kryukov"]
  spec.email = ["s.g.kryukov@yandex.ru"]
  spec.summary = "Simple OpenAPI specification builder inspired by https://github.com/Rebilly/RebillyAPI"
  spec.homepage = "https://github.com/medsolutions/openapi_builder"
  spec.license = "MIT"

  spec.files = Dir["LICENSE.txt", "README.md", "lib/**/*"]
  spec.executables = ["openapi_builder"]
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.4"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
