# frozen_string_literal: true

# The gem namespace.
module Versionaire
  # Conversion function (strict) for casting an object into a version.
  # rubocop:disable Naming/MethodName
  def Version object
    converter = Converter.new object

    case object
      when String then converter.from_string
      when Array then converter.from_array
      when Hash then converter.from_hash
      when Version then object
      else converter.from_object
    end
  end
  module_function :Version

  # Aids with converting objects into valid versions.
  class Converter
    def initialize value
      @value = value
    end

    def from_string
      body = %(Use: "<major>.<minor>.<maintenance>" or "v<major>.<minor>.<maintenance>".)
      fail(Errors::Conversion, error_message(value, body)) unless Version.string_format.match? value
      Version.new string_to_arguments
    end

    def from_array
      body = "Use: [], [<major>], [<major>, <minor>], or [<major>, <minor>, <maintenance>]."
      fail(Errors::Conversion, error_message(value, body)) unless (0..3).cover?(value.size)
      Version.new array_to_arguments
    end

    def from_hash
      body = "Use: {major: <major>}, " \
             "{major: <major>, minor: <minor>}, or " \
             "{major: <major>, minor: <minor>, maintenance: <maintenance>}."
      fail(Errors::Conversion, error_message(value, body)) unless required_keys?
      Version.new value
    end

    def from_object
      fail Errors::Conversion, error_message(value, "Use: String, Array, Hash, or Version.")
    end

    private

    attr_reader :value

    def string_to_arguments
      Version.arguments(*value.tr("v", "").split(".").map(&:to_i))
    end

    def array_to_arguments
      Version.arguments(*value.dup.fill(0, value.size..2))
    end

    def required_keys?
      value.keys.all? { |key| Version.keys.include? key }
    end

    def error_message object, body
      "Invalid version conversion: #{object}. #{body}"
    end
  end
  private_constant :Converter
end
