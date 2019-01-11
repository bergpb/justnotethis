# frozen_string_literal: true

source "https://rubygems.org"

gem 'sinatra'
gem 'slim'
gem 'sinatra-activerecord'
gem 'rake'
gem 'sinatra-flash'
gem 'bcrypt'

group :production, :test do
  gem 'pg'
end

group :development, :test do
  gem "standard"
  gem 'sinatra-reloader'
  gem 'byebug'
  gem 'sqlite3'
  gem 'slim_lint'
  gem 'faker'
  gem 'rubocop'
end
