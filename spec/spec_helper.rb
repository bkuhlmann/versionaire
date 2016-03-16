# frozen_string_literal: true

require "bundler/setup"

if ENV["CI"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require "versionaire"

Dir[File.join(File.dirname(__FILE__), "support/extensions/**/*.rb")].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), "support/kit/**/*.rb")].each { |file| require file }
