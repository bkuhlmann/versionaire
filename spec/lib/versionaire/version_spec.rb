# frozen_string_literal: true

require "spec_helper"

RSpec.describe Versionaire::Version do
  subject(:version) { described_class.new major: 1, minor: 2, patch: 3 }

  describe "#initialize" do
    context "with no arguments" do
      it "answers default version" do
        expect(described_class.new).to eq(described_class.new(major: 0, minor: 0, patch: 0))
      end
    end

    context "with string value" do
      it "fails with invalid number error" do
        result = proc { described_class.new major: "1" }
        expect(&result).to raise_error(Versionaire::Error)
      end
    end

    context "with negative value" do
      it "fails with invalid number error" do
        result = proc { described_class.new major: -1 }
        expect(&result).to raise_error(Versionaire::Error)
      end
    end
  end

  describe "#+" do
    let(:other) { described_class.new major: 7, minor: 3, patch: 1 }

    it "adds versions" do
      result = version + other
      expect(result.to_s).to eq("8.5.4")
    end
  end

  describe "#-" do
    let(:other) { described_class.new major: 1, minor: 1, patch: 1 }

    it "answers new version when result remains positive" do
      result = version - other
      expect(result.to_s).to eq("0.1.2")
    end

    it "fails when result is negative" do
      other = described_class.new patch: 30
      result = proc { version - other }

      expect(&result).to raise_error(Versionaire::Error)
    end
  end

  describe "#==" do
    let(:similar) { described_class.new major: 1, minor: 2, patch: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same values" do
      it "answers true" do
        expect(version).to eq(similar)
      end
    end

    context "with different values" do
      it "answers false" do
        expect(version).not_to eq(different)
      end
    end

    context "with different type (string)" do
      it "answers false" do
        expect(version).not_to eq("1.2.3")
      end
    end

    context "with different type (array)" do
      it "answers false" do
        expect(version).not_to eq([1, 2, 3])
      end
    end

    context "with different type (hash)" do
      it "answers false" do
        expect(version).not_to eq({major: 1, minor: 2, patch: 3})
      end
    end
  end

  describe "#eql?" do
    let(:similar) { described_class.new major: 1, minor: 2, patch: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same values" do
      it "answers true" do
        expect(version).to eql(similar)
      end
    end

    context "with different values" do
      it "answers false" do
        expect(version).not_to eql(different)
      end
    end

    context "with different type" do
      it "answers false" do
        expect(version).not_to eql("1.2.3")
      end
    end
  end

  describe "#equal?" do
    let(:similar) { described_class.new major: 1, minor: 2, patch: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same instances" do
      it "answers true" do
        expect(version).to equal(version)
      end
    end

    context "with same values" do
      it "answers false" do
        expect(version).not_to equal(similar)
      end
    end

    context "with different values" do
      it "answers false" do
        expect(version).not_to equal(different)
      end
    end

    context "with different type" do
      it "answers false" do
        expect(version).not_to equal("1.2.3")
      end
    end
  end

  describe "#<=>" do
    let(:similar) { described_class.new major: 1 }

    context "when greater than" do
      subject(:version) { described_class.new major: 2 }

      it "answers 1" do
        result = version <=> similar
        expect(result).to eq(1)
      end
    end

    context "when equal to" do
      subject(:version) { described_class.new major: 1 }

      it "answers 0" do
        result = version <=> similar
        expect(result).to eq(0)
      end
    end

    context "when less than" do
      subject(:version) { described_class.new }

      it "answers -1" do
        result = version <=> similar
        expect(result).to eq(-1)
      end
    end
  end

  describe "#<" do
    let(:one) { Versionaire::Version "1.0.0" }
    let(:two) { Versionaire::Version "2.0.0" }

    it "answers true when less than" do
      expect(one < two).to be(true)
    end

    it "answers false when not less than" do
      expect(two < one).to be(false)
    end

    it "answers false when equal" do
      expect(one < Versionaire::Version("1.0.0")).to be(false)
    end
  end

  describe "#<=" do
    let(:one) { Versionaire::Version "1.0.0" }
    let(:two) { Versionaire::Version "2.0.0" }

    it "answers true when less than" do
      expect(one <= two).to be(true)
    end

    it "answers false when not less than" do
      expect(two <= one).to be(false)
    end

    it "answers true when equal" do
      expect(one <= Versionaire::Version("1.0.0")).to be(true)
    end
  end

  describe "#>" do
    let(:one) { Versionaire::Version "1.0.0" }
    let(:two) { Versionaire::Version "2.0.0" }

    it "answers true when greater than" do
      expect(two > one).to be(true)
    end

    it "answers false when not greater than" do
      expect(one > two).to be(false)
    end

    it "answers false when equal" do
      expect(one > Versionaire::Version("1.0.0")).to be(false)
    end
  end

  describe "#>=" do
    let(:one) { Versionaire::Version "1.0.0" }
    let(:two) { Versionaire::Version "2.0.0" }

    it "answers true when greater than" do
      expect(two >= one).to be(true)
    end

    it "answers false when not greater than" do
      expect(one >= two).to be(false)
    end

    it "answers true when equal" do
      expect(one >= Versionaire::Version("1.0.0")).to be(true)
    end
  end

  describe "#between?" do
    let(:one) { Versionaire::Version "1.0.0" }
    let(:two) { Versionaire::Version "2.0.0" }
    let(:three) { Versionaire::Version "3.0.0" }

    it "answers true when between" do
      expect(two.between?(one, two)).to be(true)
    end

    it "answers false when not between" do
      expect(one.between?(two, three)).to be(false)
    end
  end

  describe "#clamp" do
    let(:one) { Versionaire::Version "1.0.0" }
    let(:two) { Versionaire::Version "2.0.0" }
    let(:three) { Versionaire::Version "3.0.0" }

    it "answers minimum when less than" do
      expect(one.clamp(two, three)).to eq(two)
    end

    it "answers maximum when greater than" do
      expect(three.clamp(one, two)).to eq(two)
    end

    it "answers equal when equal" do
      expect(one.clamp(one, one)).to eq(one)
    end
  end

  describe "#hash" do
    let(:similar) { described_class.new major: 1, minor: 2, patch: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same values" do
      it "is identical" do
        expect(version.hash).to eq(similar.hash)
      end
    end

    context "with different values" do
      it "is different" do
        expect(version.hash).not_to eq(different.hash)
      end
    end

    context "with different type" do
      it "is different" do
        expect(version.hash).not_to eq("1.2.3".hash)
      end
    end
  end

  describe "inspect" do
    it "answer escaped version string" do
      expect(version.inspect).to eq(%("1.2.3"))
    end
  end

  describe "#down" do
    it "answers previous sequential major version" do
      expect(version.down(:major)).to eq(described_class[major: 0, minor: 2, patch: 3])
    end

    it "answers previous sequential minor version" do
      expect(version.down(:minor)).to eq(described_class[major: 1, minor: 1, patch: 3])
    end

    it "answers previous sequential patch version" do
      expect(version.down(:patch)).to eq(described_class[major: 1, minor: 2, patch: 2])
    end

    it "answers previous version for given value" do
      expect(version.down(:minor, 2)).to eq(described_class[major: 1, minor: 0, patch: 3])
    end

    it "fails when decreased to a negative version" do
      expectation = proc { version.down :major, 2 }
      expect(&expectation).to raise_error(Versionaire::Error, /must be.+positive/)
    end
  end

  describe "#up" do
    it "answers next sequential major version" do
      expect(version.up(:major)).to eq(described_class[major: 2, minor: 2, patch: 3])
    end

    it "answers next sequential minor version" do
      expect(version.up(:minor)).to eq(described_class[major: 1, minor: 3, patch: 3])
    end

    it "answers next sequential patch version" do
      expect(version.up(:patch)).to eq(described_class[major: 1, minor: 2, patch: 4])
    end

    it "answers next version for given value" do
      expect(version.up(:major, 10)).to eq(described_class[major: 11, minor: 2, patch: 3])
    end
  end

  describe "#bump" do
    it "answers next major version" do
      expect(version.bump(:major)).to eq(described_class[major: 2])
    end

    it "answers next minor version" do
      expect(version.bump(:minor)).to eq(described_class[major: 1, minor: 3, patch: 0])
    end

    it "answers next patch version" do
      expect(version.bump(:patch)).to eq(described_class[major: 1, minor: 2, patch: 4])
    end

    it "fails with invalid key" do
      expectation = proc { version.bump :bogus }

      expect(&expectation).to raise_error(
        Versionaire::Error, "Invalid key: :bogus. Use: major, minor, or patch."
      )
    end
  end

  describe "#to_a" do
    it "answers array" do
      expect(version.to_a).to contain_exactly(1, 2, 3)
    end
  end

  describe "#to_h" do
    it "answers hash" do
      expect(version.to_h).to eq(major: 1, minor: 2, patch: 3)
    end
  end

  describe "#to_proc" do
    it "answers a proc" do
      expect(version.to_proc).to be_a(Proc)
    end

    it "answers valid attribute" do
      expect(version.to_proc.call(:patch)).to eq(3)
    end

    it "answers values when mapped" do
      versions = [version, version]
      expect(versions.map(&:minor)).to contain_exactly(2, 2)
    end

    it "fails with invalid attribute" do
      expectation = proc { version.to_proc.call :bogus }
      expect(&expectation).to raise_error(NameError, /bogus/)
    end
  end

  describe "#to_s" do
    it "answers string" do
      expect(version.to_s).to eq("1.2.3")
    end
  end

  describe "#to_str" do
    it "answers string" do
      expect(version.to_str).to eq("1.2.3")
    end
  end
end
