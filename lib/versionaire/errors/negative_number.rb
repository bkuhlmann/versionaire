# frozen_string_literal: true

module Versionaire
  module Errors
    # Thrown when numbers are negative.
    class NegativeNumber < Base
      def initialize message = "Major, minor, and patch must be a positive number."
        super message
      end
    end
  end
end
