# frozen_string_literal: true

module Versionaire
  module Errors
    # Thrown when not using numbers.
    class InvalidNumber < Base
      def initialize message = "Major, minor, and patch must be a number."
        super message
      end
    end
  end
end
