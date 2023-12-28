# frozen_string_literal: true

RSpec.shared_context "with temporary directory" do
  using Refinements::Pathname

  let(:temp_dir) { Bundler.root.join "tmp/rspec" }

  around do |example|
    temp_dir.make_path
    example.run
    temp_dir.remove_tree
  end
end
