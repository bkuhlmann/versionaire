# frozen_string_literal: true

require "versionaire/cast"
require "versionaire/error"
require "versionaire/function"
require "versionaire/version"

module Versionaire
  DELIMITER = "."

  PATTERN = /
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
