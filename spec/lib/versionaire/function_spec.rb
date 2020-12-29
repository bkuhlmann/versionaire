# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Conversion" do
  let(:version) { Versionaire::Version[major: 1, minor: 2, patch: 3] }

  describe "Versionaire.Version" do
    context "with string" do
      it "converts major, minor, and patch" do
        expect(Versionaire.Version("1.2.3")).to eq(version)
      end

      it "converts major and minor" do
        expect(Versionaire.Version("1.2")).to eq(Versionaire::Version("1.2.0"))
      end

      it "converts major only" do
        expect(Versionaire.Version("1")).to eq(Versionaire::Version("1.0.0"))
      end

      it "converts empty string" do
        expect(Versionaire.Version("")).to eq(Versionaire::Version("0.0.0"))
      end

      it "fails with conversion error for invalid string" do
        result = proc { Versionaire.Version "bogus" }

        expect(&result).to raise_error(
          Versionaire::Errors::Cast,
          "Invalid version conversion: bogus. " \
          "Use: <major>.<minor>.<patch>, <major>.<minor>, <major>, or empty string."
        )
      end
    end

    context "with array" do
      it "converts array with three arguments" do
        expect(Versionaire.Version([1, 2, 3])).to eq(version)
      end

      it "converts array with two arguments" do
        expect(Versionaire.Version([1, 2])).to eq(Versionaire::Version("1.2.0"))
      end

      it "converts array with one argument" do
        version = Versionaire::Version[major: 1]
        expect(Versionaire.Version([1])).to eq(version)
      end

      it "converts empty array" do
        expect(Versionaire.Version([])).to eq(Versionaire::Version.new)
      end

      it "fails with conversion error for array with more than three arguments" do
        result = proc { Versionaire.Version [1, 2, 3, 4] }

        expect(&result).to raise_error(
          Versionaire::Errors::Cast,
          "Invalid version conversion: [1, 2, 3, 4]. " \
          "Use: [<major>, <minor>, <patch>], [<major>, <minor>], [<major>], or []."
        )
      end
    end

    context "with hash" do
      it "converts major, minor, and patch" do
        expect(Versionaire.Version(major: 1, minor: 2, patch: 3)).to eq(version)
      end

      it "converts major and minor" do
        expect(Versionaire.Version(major: 1, minor: 2)).to eq(Versionaire::Version("1.2.0"))
      end

      it "converts major only" do
        expect(Versionaire.Version(major: 1)).to eq(Versionaire::Version("1.0.0"))
      end

      it "converts empty hash" do
        expect(Versionaire.Version({})).to eq(Versionaire::Version("0.0.0"))
      end

      it "fails with conversion error for invalid keys" do
        result = proc { Versionaire.Version bogus: "test" }

        expect(&result).to raise_error(
          Versionaire::Errors::Cast,
          %(Invalid version conversion: {:bogus=>"test"}. ) \
          "Use: {major: <major>, minor: <minor>, patch: <patch>}, " \
          "{major: <major>, minor: <minor>}, {major: <major>}, or {}."
        )
      end
    end

    context "with version" do
      it "returns version" do
        expect(Versionaire.Version(version)).to eq(version)
      end
    end

    context "with unsupported primitive" do
      it "fails with conversion error" do
        result = proc { Versionaire.Version 1 }

        expect(&result).to raise_error(
          Versionaire::Errors::Cast,
          "Invalid version conversion: 1. Use: String, Array, Hash, or Version."
        )
      end
    end

    context "with unsupported object" do
      let(:object) { Object.new }

      it "fails with conversion error" do
        result = proc { Versionaire.Version object }

        expect(&result).to raise_error(
          Versionaire::Errors::Cast,
          "Invalid version conversion: #{object}. " \
          "Use: String, Array, Hash, or Version."
        )
      end
    end
  end
end
