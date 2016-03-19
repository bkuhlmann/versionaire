# frozen_string_literal: true

# The gem namespace.
module Versionaire
  module_function

  # Conversion function for casting (strict) a value into a version.
  # rubocop:disable Style/MethodName
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  def Version value
    case value
      when String
        fail(Errors::Conversion, Errors::Conversion.string_message) unless value =~ Version.format
        Version.new Version.arguments(*value.tr("v", "").split(".").map(&:to_i))
      when Array
        fail(Errors::Conversion, Errors::Conversion.array_message) unless (0..3).cover?(value.size)
        Version.new Version.arguments(*value.fill(0, value.size..2))
      when Hash
        valid = value.keys.all? { |key| Version.keys.include? key }
        fail(Errors::Conversion, Errors::Conversion.hash_message) unless valid
        Version.new value
      when Version
        value
      else
        fail Errors::Conversion, Errors::Conversion.primitive_message
    end
  end
end
