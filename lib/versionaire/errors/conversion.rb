# frozen_string_literal: true

module Versionaire
  module Errors
    # Thrown when attempting to convert (cast) a primitive to a version.
    class Conversion < Base
      def self.string_message
        warn "[DEPRECATION]: .string_message is deprecated and will be removed in the next major release."
        %(Invalid string conversion. Use: "<major>.<minor>.<maintenance>" or "v<major>.<minor>.<maintenance>".)
      end

      def self.array_message
        warn "[DEPRECATION]: .array_message is deprecated and will be removed in the next major release."
        "Invalid array conversion. Use: [], [<major>], [<major>, <minor>], or [<major>, <minor>, <maintenance>]."
      end

      def self.hash_message
        warn "[DEPRECATION]: .array_message is deprecated and will be removed in the next major release."
        "Invalid hash conversion. Use: {major: <major>, minor: <minor>, maintenance: <maintenance>}."
      end

      def self.primitive_message
        warn "[DEPRECATION]: .primitive_message is deprecated and will be removed in the next major release."
        "Invalid conversion. Use: String, Array, or Hash."
      end
    end
  end
end
