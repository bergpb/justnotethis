# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.7'

gem 'bcrypt'
gem 'pagy'
gem 'rake'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'sinatra-contrib'
gem 'sinatra-flash'
gem 'slim'
gem 'thin'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug'
  gem 'faker'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'rack-test'
  gem 'robocop', require: false
  gem 'shotgun'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'slim_lint'
  gem 'sqlite3'
end
