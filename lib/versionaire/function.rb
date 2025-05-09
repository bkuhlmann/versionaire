# frozen_string_literal: true

require "refinements/array"

# The gem namespace.
module Versionaire
  module_function

  # Conversion function (strict) for casting an object into a version.
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
    using Refinements::Array

    def initialize object, model: Version
      @object = object
      @model = model
    end

    def from_string
      body = "Use: <major>.<minor>.<patch>, <major>.<minor>, <major>, or empty string."
      fail Error, error_message(object, body) unless PATTERN.match? object

      string_to_version
    end

    def from_array
      body = "Use: [<major>, <minor>, <patch>], [<major>, <minor>], [<major>], or []."
      fail Error, error_message(object, body) unless (0..3).cover? object.size

      model.new(**attributes_for(object.pad(0, 3)))
    end

    def from_hash
      body = "Use: {major: <major>, minor: <minor>, patch: <patch>}, " \
             "{major: <major>, minor: <minor>}, {major: <major>}, or {}."
      fail Error, error_message(object, body) unless required_keys?

      Version[**object]
    end

    def from_object
      fail Error, error_message(object, "Use: String, Array, Hash, or Version.")
    end

    private

    attr_reader :object, :model

    def string_to_version
      object.split(DELIMITER)
            .map(&:to_i)
            .then { |numbers| numbers.pad 0, 3 }
            .then { |values| model.new(**attributes_for(values)) }
    end

    def attributes_for(values) = model.members.zip(values).to_h

    def required_keys? = object.keys.all? { |key| model.members.include? key }

    def error_message(object, body) = "Invalid version conversion: #{object}. #{body}"
  end

  private_constant :Converter
end
