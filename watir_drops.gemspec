# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'watir_drops'
  spec.version       = '0.5.7'
  spec.authors       = ['Titus Fortner']
  spec.email         = ['titusfortner@gmail.com']

  spec.summary       = %q{Page Object Framework for use with Watir}
  spec.description   = %q{This gem leverages the Watir test framework to allow for easy modeling of specific web
application information, allowing it to be decoupled from the tests}
  spec.homepage      = 'https://github.com/titusfortner/watir_drops'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'watir'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'data_magic'
  spec.add_development_dependency 'watir_model'
end
