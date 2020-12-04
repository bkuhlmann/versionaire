# frozen_string_literal: true

module Versionaire
  # Ensures an array can be filled to a certain size with default elements.
  class Filler
    def initialize pad = 0, max: 2
      @pad = pad
      @max = max
    end

    def call array
      array.dup.fill pad, array.size..max
    end

    private

    attr_reader :pad, :max
  end
end
