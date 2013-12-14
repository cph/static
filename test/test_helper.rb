if ENV['COVERAGE'] == 'on'
  require "simplecov"
  require "simplecov-json"
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
  SimpleCov.start "rails"
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# This wires up CI::Reporter for Rails 4
# It wasn't required in Rails 3; but it is now :D
require "ci/reporter/rake/minitest_loader" if ENV['CI'] == "true"

# Speed up tests: 
# http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite/
Rails.logger.level = 4

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
