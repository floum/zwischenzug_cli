lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "zwischenzug_cli/version"

Gem::Specification.new do |spec|
  spec.name          = "zwischenzug_cli"
  spec.version       = ZwischenzugCli::VERSION
  spec.authors       = ["efflamm castel"]
  spec.email         = ["efflamm.castel@gmail.com"]

  spec.summary       = 'Command Line Helpers for the Zwischenzug Project'
  spec.description   = 'Find Puzzles and more'
  spec.homepage      = 'https://github.com/floum/zwischenzug_cli'
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/floum/zwischenzug_cli'
  spec.metadata["changelog_uri"] = 'https://github.com/floum/zwischenzug_cli/CHANGES.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
