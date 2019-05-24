source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Web
gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.11'
gem 'rails_param'
# gem 'rack-cors'

# Database
gem 'mongoid'
gem 'bcrypt', '~> 3.1.7'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'webpacker'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end