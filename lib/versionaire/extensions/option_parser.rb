# frozen_string_literal: true

require "optparse"
require "versionaire"

OptionParser.accept Versionaire::Version do |value|
  Versionaire::Version value
rescue Versionaire::Errors::Base
  raise OptionParser::InvalidArgument, value
end
