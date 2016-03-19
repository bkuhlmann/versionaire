module Versionaire
  module Errors
    # Thrown when not using numbers.
    class InvalidNumber < Base
      def initialize message = "Major, minor, and maintenance must be a number."
        super
      end
    end
  end
end
