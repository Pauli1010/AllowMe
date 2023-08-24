# frozen_string_literal: true

require_relative "lib/allow_me/version"

Gem::Specification.new do |spec|
  spec.name          = "allow_me"
  spec.version       = AllowMe::VERSION
  spec.authors       = ["Paulina Kamińska"]
  spec.email         = ["p.t.kaminska@gmail.com"]

  spec.summary       = "A library for handling permissions."
  spec.description   = "A library for handling permissions."
  spec.homepage      = "https://github.com/Pauli1010"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.1"

  # spec.metadata["allowed_push_host"] = "https://github.com/Pauli1010/AllowMe"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/Pauli1010/AllowMe/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency 'haml-rails', "~> 2.1"
  spec.add_dependency 'simple_form', "~> 5.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
