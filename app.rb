require 'sinatra'
require 'slim'
require 'bcrypt'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './config/environments'

if settings.development?
  require "byebug"
  require 'sinatra/reloader'
end

set :views, "./app/views"

enable :sessions

(Dir['./app/models/*.rb'].sort + Dir['./app/controllers/*.rb'].sort).each { |file| require file }