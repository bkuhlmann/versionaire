# frozen_string_literal: true

module Versionaire
  DELIMITER = "."

  # An immutable, semantic version value object.
  # rubocop:disable Metrics/BlockLength
  Version = Struct.new :major, :minor, :patch, keyword_init: true do
    include Comparable

    def self.regex
      /
        \A(                  # Start of string and OR.
        \d*                  # Major only.
        |                    # OR pipe.
        \d+                  # Major.
        #{DELIMITER}?        # Delimiter.
        \d*                  # Minor.
        (?:#{DELIMITER}\d+)  # Passive delimiter and patch.
        )\z                  # End of OR and string.
      /x
    end

    def self.arguments major, minor, patch
      Hash[members.zip [major, minor, patch]]
    end

    def initialize major: 0, minor: 0, patch: 0
      super
      validate
      freeze
    end

    def + other
      klass = self.class
      klass.new klass.arguments(*reduce(other, :+))
    end

    def - other
      klass = self.class
      klass.new klass.arguments(*reduce(other, :-))
    end

    def == other
      hash == other.hash
    end

    alias_method :eql?, :==

    def <=> other
      to_s <=> other.to_s
    end

    def to_s
      to_a.join DELIMITER
    end

    alias_method :to_str, :to_s

    def to_a
      [major, minor, patch]
    end

    private

    def validate
      fail Errors::InvalidNumber if to_a.any? { |number| !number.is_a? Integer }
      fail Errors::NegativeNumber if to_a.any?(&:negative?)
    end

    def reduce other, action
      to_a.zip(other.to_a).map { |pair| pair.reduce action }
    end
  end
  # rubocop:enable Metrics/BlockLength
end
