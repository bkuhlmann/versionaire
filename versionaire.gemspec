# frozen_string_literal: true

$LOAD_PATH.append File.expand_path("lib", __dir__)
require "versionaire/identity"

Gem::Specification.new do |spec|
  spec.name = Versionaire::Identity.name
  spec.version = Versionaire::Identity.version
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://github.com/bkuhlmann/versionaire"
  spec.summary = "Provides an immutable, thread-safe, and semantic version type."
  spec.license = "Apache-2.0"

  spec.metadata = {
    "source_code_uri" => "https://github.com/bkuhlmann/versionaire",
    "changelog_uri" => "https://github.com/bkuhlmann/versionaire/blob/master/CHANGES.md",
    "bug_tracker_uri" => "https://github.com/bkuhlmann/versionaire/issues"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 2.6"
  spec.add_development_dependency "awesome_print", "~> 1.8"
  spec.add_development_dependency "bond", "~> 0.5"
  spec.add_development_dependency "bundler-audit", "~> 0.6"
  spec.add_development_dependency "gemsmith", "~> 13.5"
  spec.add_development_dependency "git-cop", "~> 3.5"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "hirb", "~> 0.7"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "reek", "~> 5.4"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "rubocop", "~> 0.77"
  spec.add_development_dependency "rubocop-performance", "~> 1.5"
  spec.add_development_dependency "rubocop-rake", "~> 0.3"
  spec.add_development_dependency "rubocop-rspec", "~> 1.33"
  spec.add_development_dependency "simplecov", "~> 0.13"
  spec.add_development_dependency "wirb", "~> 2.1"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]
end
