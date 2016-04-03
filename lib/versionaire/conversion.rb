# frozen_string_literal: true

# The gem namespace.
module Versionaire
  # Conversion function (strict) for casting an object into a version.
  # rubocop:disable Style/MethodName
  def Version object
    aid = VersionAid.new object

    case object
      when String then aid.convert_from_string
      when Array then aid.convert_from_array
      when Hash then aid.convert_from_hash
      when Version then object
      else aid.convert_from_object
    end
  end
  module_function :Version

  # Aids with converting objects into valid versions.
  class VersionAid
    def initialize value
      @value = value
    end

    def convert_from_string
      body = %(Use: "<major>.<minor>.<maintenance>" or "v<major>.<minor>.<maintenance>".)
      fail(Errors::Conversion, error_message(value, body)) unless value =~ Version.string_format
      Version.new string_to_arguments
    end

    def convert_from_array
      body = "Use: [], [<major>], [<major>, <minor>], or [<major>, <minor>, <maintenance>]."
      fail(Errors::Conversion, error_message(value, body)) unless (0..3).cover?(value.size)
      Version.new array_to_arguments
    end

    def convert_from_hash
      body = "Use: {major: <major>}, " \
             "{major: <major>, minor: <minor>}, or " \
             "{major: <major>, minor: <minor>, maintenance: <maintenance>}."
      fail(Errors::Conversion, error_message(value, body)) unless required_keys?
      Version.new value
    end

    def convert_from_object
      fail Errors::Conversion, error_message(value, "Use: String, Array, Hash, or Version.")
    end

    private

    attr_reader :value

    def string_to_arguments
      Version.arguments(*value.tr("v", "").split(".").map(&:to_i))
    end

    def array_to_arguments
      Version.arguments(*value.fill(0, value.size..2))
    end

    def required_keys?
      value.keys.all? { |key| Version.keys.include? key }
    end

    def error_message object, body
      "Invalid version conversion: #{object}. #{body}"
    end
  end
  private_constant :VersionAid
end
