# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "versionaire"
  spec.version = "10.0.1"
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/versionaire"
  spec.summary = "Provides an immutable, thread-safe, and semantic version type."
  spec.license = "Hippocratic-3.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/versionaire/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/versionaire/versions",
    "documentation_uri" => "https://www.alchemists.io/projects/versionaire",
    "label" => "Versionaire",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/versionaire"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.1"
  spec.add_dependency "refinements", "~> 9.1"

  spec.files = Dir["*.gemspec", "lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]
end
