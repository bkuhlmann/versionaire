# frozen_string_literal: true

require_relative "lib/versionaire/identity"

Gem::Specification.new do |spec|
  spec.name = Versionaire::Identity::NAME
  spec.version = Versionaire::Identity::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/versionaire"
  spec.summary = "Provides an immutable, thread-safe, and semantic version type."
  spec.license = "Apache-2.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/versionaire/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/versionaire/changes.html",
    "documentation_uri" => "https://www.alchemists.io/projects/versionaire",
    "source_code_uri" => "https://github.com/bkuhlmann/versionaire"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.0"
  spec.add_dependency "refinements", "~> 8.5"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]
end
