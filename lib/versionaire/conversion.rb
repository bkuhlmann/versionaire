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
      else fail Errors::Conversion, "Invalid conversion. Use: String, Array, or Hash."
    end
  end
  module_function :Version

  # Aids with converting objects into valid versions.
  class VersionAid
    def initialize value
      @value = value
    end

    def convert_from_string
      message = %(Invalid string conversion. Use: "<major>.<minor>.<maintenance>" or "v<major>.<minor>.<maintenance>".)
      fail(Errors::Conversion, message) unless value =~ Version.string_format
      Version.new string_to_arguments
    end

    def convert_from_array
      message = "Use: [], [<major>], [<major>, <minor>], or [<major>, <minor>, <maintenance>]."
      fail(Errors::Conversion, "Invalid array conversion. #{message}") unless (0..3).cover?(value.size)
      Version.new array_to_arguments
    end

    def convert_from_hash
      message = "Invalid hash conversion. Use: {major: <major>, minor: <minor>, maintenance: <maintenance>}."
      fail(Errors::Conversion, message) unless required_keys?
      Version.new value
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
  end
  private_constant :VersionAid
end
