# frozen_string_literal: true

source "https://rubygems.org"

gem 'bcrypt'
gem 'rake'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-activerecord'
gem 'sinatra-flash'
gem 'slim'
gem 'will_paginate', '~> 3.1.0'
gem "will_paginate-bulma", path: "./vendor/will_paginate-bulma"

group :production, :test do
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
