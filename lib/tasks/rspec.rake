# frozen_string_literal: true

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => error
  puts error.message
end
