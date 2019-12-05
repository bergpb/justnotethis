# frozen_string_literal: true

source "https://rubygems.org"
ruby "2.6.5"

gem 'bcrypt'
gem 'rake'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-activerecord'
gem 'sinatra-flash'
gem 'slim'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug'
  gem 'faker'
  gem 'rubocop'
  gem 'shotgun'
  gem 'slim_lint'
  gem 'sqlite3'
  gem 'standard'
end
