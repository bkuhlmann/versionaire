# frozen_string_literal: true

module Versionaire
  # Refines Kernel in order to provide a top-level Version conversion function.
  module Cast
    refine Kernel do
      def Version object
        Versionaire::Version object
      end
    end
  end
end
