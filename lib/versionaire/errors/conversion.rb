module Versionaire
  module Errors
    # Thrown when attempting to convert (cast) a primitive to a version.
    class Conversion < Base
      def self.string_message
        %(Invalid string conversion. Use: "<major>.<minor>.<maintenance>" or "v<major>.<minor>.<maintenance>".)
      end

      def self.array_message
        "Invalid array conversion. Use: [], [<major>], [<major>, <minor>], or [<major>, <minor>, <maintenance>]."
      end

      def self.hash_message
        "Invalid hash conversion. Use: {major: <major>, minor: <minor>, maintenance: <maintenance>}."
      end

      def self.primitive_message
        "Invalid conversion. Use: String, Array, or Hash."
      end
    end
  end
end
