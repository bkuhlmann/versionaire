# frozen_string_literal: true

require "spec_helper"

RSpec.describe Versionaire::Version do
  subject { described_class.new major: 1, minor: 2, maintenance: 3 }

  describe ".keys" do
    it "answers :major, :minor, and :maintenance" do
      expect(described_class::KEYS).to contain_exactly(:major, :minor, :maintenance)
    end
  end

  describe ".string_format" do
    it "matches single digit <major>.<minor>.<maintenance> format" do
      expect(described_class.string_format).to match("1.2.3")
    end

    it "matches multiple digit <major>.<minor>.<maintenance> format" do
      expect(described_class.string_format).to match("11.2222.33333333333333333")
    end

    it "matches similar version" do
      proof = described_class.new major: 1, minor: 2, maintenance: 3
      expect(described_class.string_format).to match(proof)
    end

    it "does not match without delimiters" do
      expect(described_class.string_format).to_not match("123")
    end
  end

  describe ".arguments" do
    it "answers constructor arguments" do
      expect(described_class.arguments(3, 2, 1)).to eq(major: 3, minor: 2, maintenance: 1)
    end
  end

  describe "#initialize" do
    context "with default" do
      it "does not fail with invalid number error" do
        result = -> { described_class.new }
        expect(&result).to_not raise_error
      end

      it "does not fail with negative number error" do
        result = -> { described_class.new }
        expect(&result).to_not raise_error
      end
    end

    context "with strings" do
      it "fails with invalid number error" do
        result = -> { described_class.new major: "1" }
        expect(&result).to raise_error(Versionaire::Errors::InvalidNumber)
      end
    end

    context "with negatives" do
      it "fails with invalid number error" do
        result = -> { described_class.new major: -1, maintenance: -10 }
        expect(&result).to raise_error(Versionaire::Errors::NegativeNumber)
      end
    end
  end

  describe "#+" do
    let(:other) { described_class.new major: 7, minor: 3, maintenance: 1 }

    it "adds versions" do
      result = subject + other
      expect(result.to_s).to eq("8.5.4")
    end
  end

  describe "#-" do
    context "when result remains positive" do
      let(:other) { described_class.new major: 1, minor: 1, maintenance: 1 }

      it "subtracts versions" do
        result = subject - other
        expect(result.to_s).to eq("0.1.2")
      end
    end

    context "when result is negative" do
      let(:other) { described_class.new maintenance: 30 }

      it "raises negative number error" do
        result = -> { subject - other }
        expect(&result).to raise_error(Versionaire::Errors::NegativeNumber)
      end
    end
  end

  describe "#==" do
    let(:similar) { described_class.new major: 1, minor: 2, maintenance: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same instances" do
      it "answers true" do
        expect(subject).to eq(subject)
      end
    end

    context "with same values" do
      it "answers true" do
        expect(subject).to eq(similar)
      end
    end

    context "with different values" do
      it "answers false" do
        expect(subject).to_not eq(different)
      end
    end

    context "with different type" do
      it "answers false" do
        expect(subject).to_not eq("1.2.3")
      end
    end
  end

  describe "#eql?" do
    let(:similar) { described_class.new major: 1, minor: 2, maintenance: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same instances" do
      it "answers true" do
        expect(subject).to eql(subject)
      end
    end

    context "with same values" do
      it "answers true" do
        expect(subject).to eql(similar)
      end
    end

    context "with different values" do
      it "answers false" do
        expect(subject).to_not eql(different)
      end
    end

    context "with different type" do
      it "answers false" do
        expect(subject).to_not eql("1.2.3")
      end
    end
  end

  describe "#equal?" do
    let(:similar) { described_class.new major: 1, minor: 2, maintenance: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same instances" do
      it "answers true" do
        expect(subject).to equal(subject)
      end
    end

    context "with same values" do
      it "answers false" do
        expect(subject).to_not equal(similar)
      end
    end

    context "with different values" do
      it "answers false" do
        expect(subject).to_not equal(different)
      end
    end

    context "with different type" do
      it "answers false" do
        expect(subject).to_not equal("1.2.3")
      end
    end
  end

  describe "#<=>" do
    let(:similar) { described_class.new major: 1 }

    context "when greater than" do
      subject { described_class.new major: 2 }

      it "answers 1" do
        result = subject <=> similar
        expect(result).to eq(1)
      end
    end

    context "when equal to" do
      subject { described_class.new major: 1 }

      it "answers 0" do
        result = subject <=> similar
        expect(result).to eq(0)
      end
    end

    context "when less than" do
      subject { described_class.new }

      it "answers -1" do
        result = subject <=> similar
        expect(result).to eq(-1)
      end
    end
  end

  describe "#hash" do
    let(:similar) { described_class.new major: 1, minor: 2, maintenance: 3 }
    let(:different) { described_class.new major: 2 }

    context "with same instances" do
      it "is identical" do
        expect(subject.hash).to eq(subject.hash)
      end
    end

    context "with same values" do
      it "is identical" do
        expect(subject.hash).to eq(similar.hash)
      end
    end

    context "with different values" do
      it "is different" do
        expect(subject.hash).to_not eq(different.hash)
      end
    end

    context "with different type" do
      it "is different" do
        expect(subject.hash).to_not eq("1.2.3".hash)
      end
    end
  end

  describe "#to_s" do
    it "answers string representation" do
      expect(subject.to_s).to eq("1.2.3")
    end
  end

  describe "#to_str" do
    it "answers string representation" do
      expect(subject.to_str).to eq("1.2.3")
    end
  end

  describe "#to_a" do
    it "answers array representation" do
      expect(subject.to_a).to contain_exactly(1, 2, 3)
    end
  end

  describe "#to_h" do
    it "answers hash representation" do
      expect(subject.to_h).to eq(major: 1, minor: 2, maintenance: 3)
    end
  end
end
