# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fattura24/version'

Gem::Specification.new do |spec|
  spec.name          = 'fattura24'
  spec.version       = Fattura24::VERSION
  spec.authors       = ['Stefano Nada']
  spec.email         = ['stefano.nada@gmail.com']

  spec.summary       = 'Ruby wrapper for fattura24 apis'
  spec.description   = 'Minimal Ruby 2 wrapper for fattura24 apis.'
  spec.homepage      = 'https://github.com/snada/fattura24'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have
  # been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.8'
  spec.add_development_dependency 'simplecov', '~> 0.18'
end
