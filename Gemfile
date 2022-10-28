# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'bootsnap', '~> 1.13', require: false
gem 'bootstrap-sass', '3.4.1'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise_token_auth', '~> 1.2'
gem 'faker', '~> 2.23'
gem 'importmap-rails', '~> 1.1', '>= 1.1.5'
gem 'jbuilder', '~> 2.6'
gem 'jsonapi-serializer', '~> 2.2'
gem 'pagy', '~> 5.10'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.2'
gem 'rails', '7.0.3'
gem 'redis', '~> 4.0'
gem 'sassc-rails', '2.1.2'
gem 'sidekiq', '~> 6.5', '>= 6.5.7'
gem 'sidekiq-cron', '~> 1.7'
gem 'sprockets-rails'
gem 'stimulus-rails', '~> 1.1'
gem 'turbo-rails', '~> 1.3'
gem 'tzinfo-data', '~> 1.2022', '>= 1.2022.4', platforms: %i[mingw mswin x64_mingw jruby]
gem 'paranoia', '~> 2.6'
group :development, :test do
  gem 'debug', '~> 1.6', '>= 1.6.2', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-rails', '~> 5.1.2'
  gem 'rubocop', '~> 1.36', require: false
end

group :development do
  gem 'brakeman', '~> 5.3', '>= 5.3.1'
  gem 'bullet', '~> 7.0', '>= 7.0.3'
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'capybara', '~> 3.37', '>= 3.37.1'
  gem 'pundit-matchers', '~> 1.7'
  gem 'rspec-sidekiq', '~> 3.1'
  gem 'selenium-webdriver', '~> 4.4'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'webdrivers', '~> 5.1'
end
