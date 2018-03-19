# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Versionaire.Version" do
  let(:version) { Versionaire::Version.new major: 1, minor: 2, maintenance: 3 }

  describe ".Version" do
    context "with string" do
      it "converts version string" do
        expect(Versionaire.Version("1.2.3")).to eq(version)
      end

      it "does not modify parameters" do
        params = "1.2.3"
        Versionaire.Version params

        expect(params).to eq("1.2.3")
      end

      it "fails with conversion error for invalid string" do
        result = -> { Versionaire.Version "bogus" }
        message = "Invalid version conversion: bogus. " +
                  %(Use: "<major>.<minor>.<maintenance>" or "v<major>.<minor>.<maintenance>".)

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
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

      it "does not modify parameters" do
        params = [1]
        Versionaire.Version params

        expect(params).to contain_exactly(1)
      end

      it "fails with conversion error for array with more than three arguments" do
        result = -> { Versionaire.Version [1, 2, 3, 4] }
        message = "Invalid version conversion: [1, 2, 3, 4]. " \
                  "Use: [], [<major>], [<major>, <minor>], or [<major>, <minor>, <maintenance>]."

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
      end
    end

    context "with hash" do
      it "converts hash with required keys" do
        expect(Versionaire.Version(major: 1, minor: 2, maintenance: 3)).to eq(version)
      end

      it "converts hash with partial keys" do
        version = Versionaire::Version.new minor: 2
        expect(Versionaire.Version(minor: 2)).to eq(version)
      end

      it "fails with conversion error for invalid keys" do
        result = -> { Versionaire.Version bogus: "test" }
        message = %(Invalid version conversion: {:bogus=>"test"}. ) \
                  "Use: {major: <major>}, " \
                  "{major: <major>, minor: <minor>}, or " \
                  "{major: <major>, minor: <minor>, maintenance: <maintenance>}."

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
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
        message = "Invalid version conversion: 1. Use: String, Array, Hash, or Version."

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
      end
    end

    context "with unsupported object" do
      let(:object) { double :object }

      it "fails with conversion error" do
        result = -> { Versionaire.Version object }
        message = "Invalid version conversion: #[Double :object]. " \
                  "Use: String, Array, Hash, or Version."

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
      end
    end
  end
end
