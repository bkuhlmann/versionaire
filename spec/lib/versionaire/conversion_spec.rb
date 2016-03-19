# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Versionaire.Version" do
  let(:version) { Versionaire::Version.new major: 1, minor: 2, maintenance: 3 }

  describe ".Version" do
    context "with string" do
      it "converts version string" do
        expect(Versionaire.Version("1.2.3")).to eq(version)
      end

      it "converts labeled version string" do
        expect(Versionaire.Version("v1.2.3")).to eq(version)
      end

      it "fails with conversion error for invalid string" do
        result = -> { Versionaire.Version "bogus" }
        expect(&result).to raise_error(Versionaire::Errors::Conversion, /Invalid string conversion/)
      end
    end

    context "with array" do
      it "converts empty array" do
        expect(Versionaire.Version([])).to eq(Versionaire::Version.new)
      end

      it "converts array with one argument" do
        version = Versionaire::Version.new major: 1
        expect(Versionaire.Version([1])).to eq(version)
      end

      it "converts array with two arguments" do
        version = Versionaire::Version.new major: 1, minor: 2
        expect(Versionaire.Version([1, 2])).to eq(version)
      end

      it "converts array with three arguments" do
        expect(Versionaire.Version([1, 2, 3])).to eq(version)
      end

      it "fails with conversion error for array with more than three arguments" do
        result = -> { Versionaire.Version [1, 2, 3, 4] }
        expect(&result).to raise_error(Versionaire::Errors::Conversion, /Invalid array conversion/)
      end
    end

    context "with hash" do
      it "converts hash with all keys" do
        expect(Versionaire.Version(major: 1, minor: 2, maintenance: 3)).to eq(version)
      end

      it "converts hash with partial keys" do
        version = Versionaire::Version.new minor: 2
        expect(Versionaire.Version(minor: 2)).to eq(version)
      end

      it "fails with conversion error for invalid hash" do
        result = -> { Versionaire.Version bogus: "test" }
        expect(&result).to raise_error(Versionaire::Errors::Conversion, /Invalid hash conversion/)
      end
    end

    context "with version" do
      it "returns version" do
        expect(Versionaire.Version(version)).to eq(version)
      end
    end

    context "with unsupported primitive" do
      it "fails with conversion error" do
        result = -> { Versionaire.Version 1 }
        expect(&result).to raise_error(Versionaire::Errors::Conversion, /Invalid conversion/)
      end
    end

    context "with unsupported object" do
      let(:object) { double :object }

      it "fails with conversion error" do
        result = -> { Versionaire.Version object }
        expect(&result).to raise_error(Versionaire::Errors::Conversion, /Invalid conversion/)
      end
    end
  end
end
