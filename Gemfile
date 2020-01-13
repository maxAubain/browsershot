# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.3'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'bootsnap', '~> 1.4', '>= 1.4.5'

# Screenshot capture and image conditioning
gem 'mini_magick', '~> 4.10', '>= 4.10.1'
gem 'ruby_webshot', '~> 0.0.6'
gem 'selenium-webdriver', '~> 3.142', '>= 3.142.7'
gem 'webdrivers', '~> 4.2'

# SASS stylesheets
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'

# For future use to enable async methods regarding generation of screen shots
# gem 'concurrent-ruby', '~> 1.1', '>= 1.1.5'

group :development, :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
