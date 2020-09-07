# frozen_string_literal: true

require 'rake/testtask'
require 'securerandom'
require 'sinatra/activerecord/rake'
require File.dirname(__FILE__) + '/app'

desc 'Run server with Shotgun and Thin'
task :serve do
  sh 'shotgun config.ru'
end

desc 'Run Slim linter'
task :slim_linter do
  sh 'slim-lint views'
end

desc "Generate a cryptographically secure secret key (this is typically used to generate a secret for cookie sessions)."
task :secret do
  puts SecureRandom.hex(32)
end


task default: 'test'
Rake::TestTask.new do |t|
  t.pattern = 'tests/*_test.rb'
  t.verbose = false
  t.warning = false
end
