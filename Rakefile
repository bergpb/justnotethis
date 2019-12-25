require "./app"
require "standard/rake"
require "sinatra/activerecord/rake"
require 'rake/testtask'

desc "Run server with shotgun"
task :serve do
  sh "shotgun app.rb"
end

task default: "test"
Rake::TestTask.new do |task|
 task.pattern = 'tests/*_test.rb'
 task.verbose = false
 task.warning = false
end

