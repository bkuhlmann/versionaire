# frozen_string_literal: true

module Versionaire
  # An immutable, semantic version value object.
  class Version
    include Comparable

    attr_reader :major, :minor, :maintenance

    def self.keys
      %i(major minor maintenance)
    end

    def self.string_format
      /
        \A     # Start of string.
        v?     # Optional prefix.
        \d{1,} # Major version.
        \.     # Delimiter.
        \d{1,} # Minor version.
        \.     # Delimiter.
        \d{1,} # Maintenance version.
        \z     # End of string.
      /x
    end

    def self.arguments major, minor, maintenance
      Hash[keys.zip [major, minor, maintenance]]
    end

    def initialize major: 0, minor: 0, maintenance: 0
      @major = major
      @minor = minor
      @maintenance = maintenance
      validate
    end

    def + other
      self.class.new self.class.arguments(*reduce(other, :+))
    end

    def - other
      self.class.new self.class.arguments(*reduce(other, :-))
    end

    def == other
      other.is_a?(Version) && to_s == other.to_s
    end
    alias eql? ==

    def <=> other
      to_s <=> other.to_s
    end

    def hash
      [major, minor, maintenance, self.class].hash
    end

    def label
      "v#{self}"
    end

    def to_s
      "#{major}.#{minor}.#{maintenance}"
    end
    alias to_str to_s

    def to_a
      [major, minor, maintenance]
    end

    def to_h
      {major: major, minor: minor, maintenance: maintenance}
    end

    private

    def validate
      fail(Errors::InvalidNumber) if to_a.any? { |number| !number.is_a? Integer }
      fail(Errors::NegativeNumber) if to_a.any? { |number| number < 0 }
    end

    def reduce other, action
      to_a.zip(other.to_a).map { |pair| pair.reduce(action) }
    end
  end
end
