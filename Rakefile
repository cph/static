# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

# When `rake test` is run with `ci:setup:minitest`, this will cause the CI::Reporter formatter
# to replace the Turn formatter for the test runner. Without `ci:setup:minitest`, this line
# has no effect. (I think.)
require "ci/reporter/rake/minitest" if ENV["RAILS_ENV"] == "test"

Static::Application.load_tasks
