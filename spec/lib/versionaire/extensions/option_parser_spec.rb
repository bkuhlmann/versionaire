# frozen_string_literal: true

require "spec_helper"
require "versionaire/extensions/option_parser"

RSpec.describe OptionParser do
  using Versionaire::Cast

  subject :parser do
    described_class.new do |instance|
      instance.on "--tag VERSION", Versionaire::Version, "Casts to version." do |value|
        options[:version] = value
      end
    end
  end

  let(:options) { Hash.new }

  it "casts input as version" do
    parser.parse! %w[--tag 1.2.3]
    expect(options).to eq(version: Version("1.2.3"))
  end

  it "fails when input doesn't resemble a version" do
    expectation = proc { parser.parse! %w[--tag unknown] }
    expect(&expectation).to raise_error(described_class::InvalidArgument, /unknown/)
  end
end
