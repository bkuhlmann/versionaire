# frozen_string_literal: true

require "spec_helper"

RSpec.describe Versionaire::Filler do
  subject(:filler) { described_class.new }

  describe "#call" do
    it "answers filled array when smaller" do
      expect(filler.call([1])).to eq([1, 0, 0])
    end

    it "answers unfilled array when equal" do
      expect(filler.call([1, 2, 3])).to eq([1, 2, 3])
    end

    it "answers unfilled array when larger" do
      expect(filler.call([1, 2, 3, 4])).to eq([1, 2, 3, 4])
    end

    it "answers filled array when empty" do
      expect(filler.call([])).to eq([0, 0, 0])
    end

    it "does not mutate original array" do
      array = [1, 2]
      filler.call array

      expect(array).to eq([1, 2])
    end

    it "answers different padding when customized" do
      array = described_class.new(1).call [1]
      expect(array).to eq([1, 1, 1])
    end

    it "answers different fill when max is customized" do
      array = described_class.new(max: 3).call [1]
      expect(array).to eq([1, 0, 0, 0])
    end
  end
end
