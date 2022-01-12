# frozen_string_literal: true

source 'https://rubygems.org'

ruby "2.7.1"

gem 'bcrypt'
gem 'pagy'
gem 'rake'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'sinatra-contrib'
gem 'sinatra-flash'
gem 'slim'
gem 'thin'

gem "rexml", ">= 3.2.5"

group :production do
  gem 'pg'
end

group :development do
  gem 'byebug'
  gem 'faker'
  gem 'rerun'
  gem 'slim_lint'
  gem 'sqlite3'
  gem 'rubocop', require: false
end

group :test do
  gem 'codecov', require: false
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'rack-test'
  gem 'simplecov'
  gem 'simplecov-console'
end
