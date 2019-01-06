require 'slim'
require 'bcrypt'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require './config/environments'

if settings.development?
  require "byebug"
  require 'sinatra/reloader'
  set :bind, '0.0.0.0'
end

set :views, "./app/views"
enable :sessions

Dir.glob('./app/{models,helpers,controllers,views}/*.rb').each { |file| require file }

# 404 Error!
not_found do
  status 404
  slim :not_found
end

# 500 Error!
error 500 do
  status 500
  slim :server_error
end
