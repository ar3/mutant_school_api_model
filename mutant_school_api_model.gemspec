# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mutant_school_api_model/version'

Gem::Specification.new do |spec|
  spec.name          = "mutant_school_api_model"
  spec.version       = MutantSchoolAPIModel::VERSION
  spec.authors       = ["Dave Strus"]
  spec.email         = ["dave@getfretless.com"]

  spec.summary       = 'Mutant School API wrapper'
  spec.description   = 'Mutant School API wrapper for use in automated tests'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
  spec.add_development_dependency 'http', '~> 1.0'
  spec.add_development_dependency 'addressable', '~> 2.4'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'factory_girl', '~> 4.0'
end
