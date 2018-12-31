require 'sinatra'
require 'slim'
require 'sinatra/reloader'
require "sinatra/activerecord"
require 'sinatra/flash'
require "byebug"

set :database, "sqlite3:db/dev.db"
enable :sessions

require './models/models'
require './controllers/task'
