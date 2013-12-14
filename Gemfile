source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "4.0.1"

gem "pg"

gem "airbrake"
gem "devise"
gem "sucker_punch" # used by Airbrake to send notices asynchronously
gem "unicorn-rails"

gem "jquery-rails"
gem "twitter-bootstrap-rails"
gem "font-awesome-rails"



# Use SCSS for stylesheets
gem "sass-rails", "~> 4.0.0"

# Use LESS for stylesheets
gem "less-rails" # required by twitter-bootstrap-rails

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem "therubyracer", platforms: :ruby



group :development, :test do
  gem "letter_opener"
  gem "pry"
  gem "spring"
end

group :test do
  # For Jenkins
  gem "simplecov", :require => false
  gem "simplecov-json", :require => false, :git => "git://github.com/houstonmc/simplecov-json.git"
  gem "ci_reporter", :require => false
  gem "turn"
  gem "rr"
  gem "shoulda-context"
end
