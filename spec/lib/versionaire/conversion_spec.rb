# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Conversion", type: :feature do
  let(:version) { Versionaire::Version "1.2.3" }

  describe ".Version" do
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

      it "does not modify parameters" do
        params = "1"
        Versionaire.Version params

        expect(params).to eq("1")
      end

      it "fails with conversion error for invalid string" do
        result = -> { Versionaire.Version "bogus" }
        message = "Invalid version conversion: bogus. " \
                  "Use: <major>.<minor>.<patch>, <major>.<minor>, <major>, or empty string."

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
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

      it "does not modify parameters" do
        params = [1]
        Versionaire.Version params

        expect(params).to contain_exactly(1)
      end

      it "fails with conversion error for array with more than three arguments" do
        result = -> { Versionaire.Version [1, 2, 3, 4] }
        message = "Invalid version conversion: [1, 2, 3, 4]. " \
                  "Use: [<major>, <minor>, <patch>], [<major>, <minor>], [<major>], or []."

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
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

      it "does not modify parameters" do
        params = {major: 1}
        Versionaire.Version params

        expect(params).to eq(major: 1)
      end

      it "fails with conversion error for invalid keys" do
        result = -> { Versionaire.Version bogus: "test" }
        message = %(Invalid version conversion: {:bogus=>"test"}. ) \
                  "Use: {major: <major>, minor: <minor>, patch: <patch>}, " \
                  "{major: <major>, minor: <minor>}, {major: <major>}, or {}."

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
      let(:object) { Object.new }

      it "fails with conversion error" do
        result = -> { Versionaire.Version object }
        message = "Invalid version conversion: #{object}. " \
                  "Use: String, Array, Hash, or Version."

        expect(&result).to raise_error(Versionaire::Errors::Conversion, message)
      end
    end
  end
end
