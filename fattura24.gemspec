# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fattura24/version'

file_regex = /^(
  \.env.example|
  \.dockerignore|
  \.gitignore|
  \.rspec|
  \.rubocop.yml|
  \.ruby-version|
  \.travis.yml|
  \.codeclimate.yml|
  Makefile|
  Dockerfile\.|
  test|
  spec|
  bin
)/x

Gem::Specification.new do |spec|
  spec.name          = 'fattura24'
  spec.version       = Fattura24::VERSION
  spec.authors       = ['Stefano Nada']
  spec.email         = ['stefano.nada@gmail.com']

  spec.summary       = 'Ruby wrapper for fattura24 apis'
  spec.description   = 'Minimal Ruby 2 wrapper for fattura24 apis.'
  spec.homepage      = 'https://github.com/snada/fattura24'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(file_regex)
    end
  end

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '> 4.2'
  spec.add_runtime_dependency 'builder'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'dotenv', '~> 2.7'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rdoc', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.8'
  spec.add_development_dependency 'simplecov', '~> 0.18'
  spec.add_development_dependency 'webmock', '~> 3.8'
end
