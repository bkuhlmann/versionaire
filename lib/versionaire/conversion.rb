# frozen_string_literal: true

# The gem namespace.
module Versionaire
  module_function

  # Conversion function (strict) for casting an object into a version.
  # :reek:TooManyStatements
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

  # Aids with converting objects into valid versions.
  class Converter
    def initialize object
      @object = object
    end

    def from_string
      body = %(Use: "<major>.<minor>.<patch>".)
      fail Errors::Conversion, error_message(object, body) unless Version.regex.match? object

      Version[string_to_arguments]
    end

    def from_array
      body = "Use: [], [<major>], [<major>, <minor>], or [<major>, <minor>, <patch>]."
      fail Errors::Conversion, error_message(object, body) unless (0..3).cover? object.size

      Version[array_to_arguments]
    end

    def from_hash
      body = "Use: {major: <major>}, " \
             "{major: <major>, minor: <minor>}, or " \
             "{major: <major>, minor: <minor>, patch: <patch>}."
      fail Errors::Conversion, error_message(object, body) unless required_keys?

      Version[object]
    end

    def from_object
      fail Errors::Conversion, error_message(object, "Use: String, Array, Hash, or Version.")
    end

    private

    attr_reader :object

    def string_to_arguments
      Version.arguments(*object.split(".").map(&:to_i))
    end

    def array_to_arguments
      Version.arguments(*object.dup.fill(0, object.size..2))
    end

    def required_keys?
      object.keys.all? { |key| VERSION_ATTRIBUTES.include? key }
    end

    def error_message object, body
      "Invalid version conversion: #{object}. #{body}"
    end
  end

  private_constant :Converter
end
