source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Web
gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.11'
# gem 'rack-cors'

# API
gem 'devise'
gem 'rails_param'
gem 'blueprinter'

# Database
gem 'mongoid', '~> 7.0'
gem 'bcrypt', '~> 3.1.7'
gem 'bson_ext'

# Utils
gem 'aws-sdk'
gem 'faraday'

# Swagger
gem 'rswag-api'
gem 'rswag-ui'

group :development do
  gem 'webpacker'

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rubocop', require: false
  gem 'rubocop-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.8'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'database_cleaner'
  gem 'simplecov'

  gem 'mongoid-rspec'

  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'rswag-specs'
end