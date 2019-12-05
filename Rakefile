require "standard/rake"
require "sinatra/activerecord/rake"
require "./app"

desc "run server"
task :serve do
  sh "shotgun --port=4567 app.rb"
end
