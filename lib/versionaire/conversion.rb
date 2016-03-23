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
      else fail Errors::Conversion, Errors::Conversion.primitive_message
    end
  end
  module_function :Version

  # Aids with converting objects into valid versions.
  class VersionAid
    def initialize value
      @value = value
    end

    def convert_from_string
      fail(Errors::Conversion, Errors::Conversion.string_message) unless value =~ Version.format
      Version.new string_to_arguments
    end

    def convert_from_array
      fail(Errors::Conversion, Errors::Conversion.array_message) unless (0..3).cover?(value.size)
      Version.new array_to_arguments
    end

    def convert_from_hash
      fail(Errors::Conversion, Errors::Conversion.hash_message) unless required_keys?
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
