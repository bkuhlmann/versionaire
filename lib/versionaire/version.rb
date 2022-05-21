# frozen_string_literal: true

require "refinements/structs"

module Versionaire
  # An immutable, semantic version value object.
  Version = Struct.new :major, :minor, :patch, keyword_init: true do
    include Comparable

    using Refinements::Structs

    def self.delimiter = "."

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

    def +(other) = revalue(other.to_h) { |previous, current| previous + current }

    def -(other) = revalue(other.to_h) { |previous, current| previous - current }

    def ==(other) = hash == other.hash

    alias_method :eql?, :==

    def <=>(other) = to_s <=> other.to_s

    def down(key, value = 1) = revalue(key => value) { |previous, current| previous - current }

    def up(key, value = 1) = revalue(key => value) { |previous, current| previous + current }

    def inspect = to_s.inspect

    def to_proc = method(:[]).to_proc

    def to_s = to_a.join(self.class.delimiter)

    alias_method :to_str, :to_s

    private

    def validate
      fail Error, "Major, minor, and patch must be a number." if to_a.any? do |number|
                                                                   !number.is_a? Integer
                                                                 end

      fail Error, "Major, minor, and patch must be a positive number." if to_a.any?(&:negative?)
    end
  end
end
