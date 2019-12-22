require 'pagy'
require 'slim'
require 'bcrypt'
require 'sinatra'
require 'sinatra/flash'
require 'pagy/extras/bulma'
require 'sinatra/multi_route'
require 'sinatra/activerecord'
require './config/environments'

# require models
Dir['./app/models/*.rb'].each { |file| require_relative file }
# require helpers
Dir['./app/helpers/*.rb'].each { |file| require_relative file }
# require controllers
Dir['./app/controllers/*.rb'].each { |file| require_relative file }
# require views
Dir['./app/views/*.rb'].each { |file| require_relative file }

set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root, 'app/views') }
set :public_folder, File.dirname(__FILE__) + '/static'
set :session_secret, ENV['SECRET_KEY']

# expire after one week
set :sessions, :expire_after => 604800

# set max itens per page
Pagy::VARS[:items] = 12
