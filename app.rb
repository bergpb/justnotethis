require 'slim'
require 'bcrypt'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/activerecord'
require './config/environments'

if settings.development?
  require 'byebug'
  require 'sinatra/reloader'
end

Dir.glob(File.dirname(__FILE__) + '/app/{models,helpers,controllers,views}/*.rb').each { |file| require file }

set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root, 'app/views') }
enable :sessions

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
