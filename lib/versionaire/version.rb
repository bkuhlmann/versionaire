# frozen_string_literal: true

require "refinements/array"
require "refinements/struct"

module Versionaire
  # An immutable, semantic version value object.
  Version = Struct.new :major, :minor, :patch do
    include Comparable

    using Refinements::Array
    using Refinements::Struct

    def initialize major: 0, minor: 0, patch: 0
      super
      validate
      freeze
    end

    def []= key, value
      super.tap { validate }
    end

    def +(other) = (revalue(other.to_h) { |previous, current| previous + current }).freeze

    def -(other) = (revalue(other.to_h) { |previous, current| previous - current }).freeze

    def ==(other) = hash == other.hash

    alias_method :eql?, :==

    def <=>(other) = to_s <=> other.to_s

    def down key, value = 1
      (revalue(key => value) { |previous, current| previous - current }).freeze
    end

    def up key, value = 1
      (revalue(key => value) { |previous, current| previous + current }).freeze
    end

    def bump key
      case key
        when :major then bump_major
        when :minor then bump_minor
        when :patch then bump_patch
        else fail Error, %(Invalid key: #{key.inspect}. Use: #{members.to_sentence "or"}.)
      end
    end

    def inspect = to_s.inspect

    def to_proc = method(:[]).to_proc

    def to_s = to_a.join DELIMITER

    alias_method :to_str, :to_s

    private

    def validate
      fail Error, "Major, minor, and patch must be a number." if to_a.any? do |number|
                                                                   !number.is_a? Integer
                                                                 end

      fail Error, "Major, minor, and patch must be a positive number." if to_a.any?(&:negative?)
    end

    def bump_major = merge(major: major + 1, minor: 0, patch: 0).freeze

    def bump_minor = merge(major:, minor: minor + 1, patch: 0).freeze

    def bump_patch = merge(major:, minor:, patch: patch + 1).freeze
  end
end
