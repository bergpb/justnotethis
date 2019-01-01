require 'sinatra'
require 'slim'
require 'bcrypt'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './config/environments'

if settings.development?
  require "byebug"
end

set :views, "./app/views"

enable :sessions

class App < Sinatra::Base
  (Dir['./app/models/*.rb'].sort + Dir['./app/controllers/*.rb'].sort).each { |file| require file }
end