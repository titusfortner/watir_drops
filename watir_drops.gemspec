# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'watir_drops/version'

Gem::Specification.new do |spec|
  spec.name          = "watir_drops"
  spec.version       = WatirDrops::VERSION
  spec.authors       = ["Titus Fortner"]
  spec.email         = ["titusfortner@gmail.com"]

  spec.summary       = %q{Page Object Framework for use with Watir}
  spec.description   = %q{This gem leverages the Watir test framework to allow for easy modeling of specific web
application information, allowing it to be decoupled from the tests}
  spec.homepage      = "https://github.com/titusfortner/watir_drops"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 0"
  spec.add_development_dependency "watir-webdriver", "~> 0.8.0"
end
