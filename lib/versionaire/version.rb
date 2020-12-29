# frozen_string_literal: true

require "refinements/structs"

module Versionaire
  # An immutable, semantic version value object.
  Version = Struct.new :major, :minor, :patch, keyword_init: true do
    include Comparable

    using Refinements::Structs

    def self.delimiter
      "."
    end

    def self.pattern
      /
        \A(                  # Start of string and OR.
        \d*                  # Major only.
        |                    # OR pipe.
        \d+                  # Major.
        #{delimiter}?        # Delimiter.
        \d*                  # Minor.
        (?:#{delimiter}\d+)  # Passive delimiter and patch.
        )\z                  # End of OR and string.
      /x
    end

    def initialize major: 0, minor: 0, patch: 0
      super
      validate
      freeze
    end

    def []= key, value
      super(key, value).tap { validate }
    end

    def + other
      revalue(other.to_h) { |previous, current| previous + current }
    end

    def - other
      revalue(other.to_h) { |previous, current| previous - current }
    end

    def == other
      hash == other.hash
    end

    alias_method :eql?, :==

    def <=> other
      to_s <=> other.to_s
    end

    def down key, value = 1
      revalue(key => value) { |previous, current| previous - current }
    end

    def up key, value = 1
      revalue(key => value) { |previous, current| previous + current }
    end

    def to_s
      to_a.join self.class.delimiter
    end

    alias_method :to_str, :to_s
    alias_method :values, :to_a

    private

    def validate
      fail Errors::InvalidNumber if to_a.any? { |number| !number.is_a? Integer }
      fail Errors::NegativeNumber if to_a.any?(&:negative?)
    end
  end
end
