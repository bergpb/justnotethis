# frozen_string_literal: true

require 'pagy'
require 'slim'
require 'bcrypt'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'pagy/extras/bulma'
require 'sinatra/multi_route'
require 'sinatra/activerecord'
require './config/environments'

# require models
Dir['./models/*.rb'].each { |file| require_relative file }
# require helpers
Dir['./helpers/*.rb'].each { |file| require_relative file }
# require controllers
Dir['./controllers/*.rb'].each { |file| require_relative file }
# require views
Dir['./views/*.rb'].each { |file| require_relative file }

set :root, File.dirname(__FILE__)
set :environment, ENV['RACK_ENV']
set :public_folder, File.dirname(__FILE__) + '/static'
set :session_secret, ENV['SECRET_KEY']
set :server, 'thin'

# expire after one week
set :sessions, expire_after: 604800

# set max itens per page
Pagy::VARS[:items] = 12
