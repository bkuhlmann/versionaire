# frozen_string_literal: true

require "spec_helper"

RSpec.describe Versionaire do
  describe "PATTERN" do
    it "matches empty string" do
      expect(described_class::PATTERN).to match("")
    end

    it "matches major only format" do
      expect(described_class::PATTERN).to match("1")
    end

    it "matches major and minor only format" do
      expect(described_class::PATTERN).to match("1.2")
    end

    it "matches major, minor, and patch format" do
      expect(described_class::PATTERN).to match("1.2.3")
    end

    it "matches multiple digit major, minor, and patch format" do
      expect(described_class::PATTERN).to match("11.222.3333")
    end

    it "matches similar version" do
      proof = described_class::Version.new major: 1, minor: 2, patch: 3
      expect(described_class::PATTERN).to match(proof)
    end

    it "does not match trailing major delimiter" do
      expect(described_class::PATTERN).not_to eq("1.")
    end

    it "does not match trailing minor delimiter" do
      expect(described_class::PATTERN).not_to eq("1.2.")
    end

    it "does not match trailing patch delimiter" do
      expect(described_class::PATTERN).not_to match("1.2.3.")
    end

    it "does not match numbers beyond patch" do
      expect(described_class::PATTERN).not_to match("1.2.3.4")
    end

    it "does not match letters" do
      expect(described_class::PATTERN).not_to match("a.b.c")
    end
  end
end
