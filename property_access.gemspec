# frozen_string_literal: true

require_relative "lib/property_access/version"

Gem::Specification.new do |spec|
  spec.name = "property_access"
  spec.version = PropertyAccess::VERSION
  spec.authors = ["Alipio de Paula"]
  spec.email = ["alipiodepaula@gmail.com"]

  spec.summary = "Provides functions to read and write from/to an object or array using a simple dotted path notation."
  spec.description = "Provides functions to read and write from/to an object or array using a simple dotted path notation."
  spec.homepage = "https://github.com/alipio/property_access"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
