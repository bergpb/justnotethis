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

# 404 Error!
not_found do
  status 404
  slim :index
end

# 500 Error!
error 500 do
  status 500
  slim :index
end
