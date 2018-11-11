# frozen_string_literal: true

require "spec_helper"

RSpec.describe Versionaire::Errors::InvalidNumber do
  subject(:error) { described_class.new }

  describe "#initialize" do
    it "answers default message" do
      expect(error.message).to eq("Major, minor, and maintenance must be a number.")
    end
  end
end
