module Versionaire
  module Errors
    # Thrown when numbers are negative.
    class NegativeNumber < Base
      def initialize message = "Major, minor, and maintenance must be a positive number."
        super
      end
    end
  end
end
