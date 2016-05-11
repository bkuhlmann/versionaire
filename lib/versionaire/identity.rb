# frozen_string_literal: true

module Versionaire
  # Gem identity information.
  module Identity
    def self.name
      "versionaire"
    end

    def self.label
      "Versionaire"
    end

    def self.version
      "1.2.0"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
