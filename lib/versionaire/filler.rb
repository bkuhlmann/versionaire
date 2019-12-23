# frozen_string_literal: true

module Versionaire
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
