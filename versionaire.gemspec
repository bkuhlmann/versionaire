# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "versionaire"
  spec.version = "13.5.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/versionaire"
  spec.summary = "An immutable, thread-safe, and strict semantic version type."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/versionaire/issues",
    "changelog_uri" => "https://alchemists.io/projects/versionaire/versions",
    "documentation_uri" => "https://alchemists.io/projects/versionaire",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Versionaire",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/versionaire"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.3"
  spec.add_dependency "refinements", "~> 12.7"

  spec.files = Dir["*.gemspec", "lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
end
