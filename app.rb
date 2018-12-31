require 'sinatra'
require 'slim'
require 'bcrypt'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/flash'

if settings.development?
  require "byebug"
  set :database, "sqlite3:db/dev.db"
else
  set :database, "sqlite3:db/production.db"
end

enable :sessions

require './models/models'
require './controllers/task'
require './controllers/user'
require './controllers/session'
