# frozen_string_literal: true

require "refinements/arrays"
require "refinements/structs"

# The gem namespace.
module Versionaire
  module_function

  # Conversion function (strict) for casting an object into a version.
  # :reek:TooManyStatements
  def Version object
    Converter.new(object).then do |converter|
      case object
        when String then converter.from_string
        when Array then converter.from_array
        when Hash then converter.from_hash
        when Version then object
        else converter.from_object
      end
    end
  end

  # Aids with converting objects into valid versions.
  class Converter
    using Refinements::Arrays
    using Refinements::Structs

    def initialize object
      @object = object
    end

    def from_string
      body = "Use: <major>.<minor>.<patch>, <major>.<minor>, <major>, or empty string."
      fail Errors::Conversion, error_message(object, body) unless Version.pattern.match? object

      string_to_version
    end

    def from_array
      body = "Use: [<major>, <minor>, <patch>], [<major>, <minor>], [<major>], or []."
      fail Errors::Conversion, error_message(object, body) unless (0..3).cover? object.size

      Version.with_positions(*object.pad(0, max: 3))
    end

    def from_hash
      body = "Use: {major: <major>, minor: <minor>, patch: <patch>}, " \
             "{major: <major>, minor: <minor>}, {major: <major>}, or {}."
      fail Errors::Conversion, error_message(object, body) unless required_keys?

      Version[**object]
    end

    def from_object
      fail Errors::Conversion, error_message(object, "Use: String, Array, Hash, or Version.")
    end

    private

    attr_reader :object, :filler

    def string_to_version
      object.split(DELIMITER)
            .map(&:to_i)
            .then { |numbers| numbers.pad 0, max: 3 }
            .then { |arguments| Version.with_positions(*arguments) }
    end

    def required_keys?
      object.keys.all? { |key| Version.members.include? key }
    end

    def error_message object, body
      "Invalid version conversion: #{object}. #{body}"
    end
  end

  private_constant :Converter
end
