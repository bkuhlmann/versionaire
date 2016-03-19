# frozen_string_literal: true

require "spec_helper"

RSpec.describe Versionaire::Errors::NegativeNumber do
  subject { described_class.new }

  describe "#initialize" do
    it "answers default message" do
      expect(subject.message).to eq("Major, minor, and maintenance must be a positive number.")
    end
  end
end
