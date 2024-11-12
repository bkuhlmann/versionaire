# frozen_string_literal: true

require "refinements/array"

module Versionaire
  # An immutable, semantic version value object.
  Version = Data.define :major, :minor, :patch do
    include Comparable

    using Refinements::Array

    def initialize major: 0, minor: 0, patch: 0
      super
      validate
    end

    def +(other) = add other

    def -(other) = substract other

    def ==(other) = hash == other.hash

    alias_method :eql?, :==

    def <=>(other) = to_s <=> other.to_s

    def down(key, value = 1) = substract({key => value})

    def up(key, value = 1) = add({key => value})

    def bump key
      case key
        when :major then bump_major
        when :minor then bump_minor
        when :patch then bump_patch
        else fail Error, %(Invalid key: #{key.inspect}. Use: #{members.to_sentence "or"}.)
      end
    end

    def inspect = to_s.inspect

    def to_proc = method(:public_send).to_proc

    def to_s = to_a.join DELIMITER

    alias_method :to_str, :to_s

    alias_method :to_a, :deconstruct

    private

    def validate
      fail Error, "Major, minor, and patch must be a number." unless to_a.all? Integer
      fail Error, "Major, minor, and patch must be a positive number." if to_a.any?(&:negative?)
    end

    def add other
      attributes = other.to_h
      attributes.each { |key, value| attributes[key] = public_send(key) + value }
      with(**attributes)
    end

    def substract other
      attributes = other.to_h
      attributes.each { |key, value| attributes[key] = public_send(key) - value }
      with(**attributes)
    end

    def bump_major = with major: major + 1, minor: 0, patch: 0

    def bump_minor = with major:, minor: minor + 1, patch: 0

    def bump_patch = with major:, minor:, patch: patch + 1
  end
end
