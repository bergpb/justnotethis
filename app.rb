require 'slim'
require 'bcrypt'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/multi_route'
require 'sinatra/activerecord'
require './config/environments'

if settings.development?
  require 'byebug'
end

Dir.glob(File.dirname(__FILE__) + '/app/{models,helpers,controllers,views}/*.rb').each {|file| require file}

set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root, 'app/views') }
set :public_folder, File.dirname(__FILE__) + '/static'
set :session_secret, ENV['SECRET_KEY']

enable :sessions