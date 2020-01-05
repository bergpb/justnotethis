# frozen_string_literal: true


require 'simplecov'
require 'simplecov-console'
require 'codecov'

SimpleCov.start do
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Console,
      SimpleCov::Formatter::Codecov
    ]
  )
end

require 'minitest/autorun'
require 'rack/test'
require 'minitest/reporters'
require File.expand_path(File.join(__dir__, '..', 'app.rb'))

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(
  color: true
)]

Minitest.after_run do
  puts 'Removing test database...'
  system 'rm -f db/test.sqlite3'
end

class Minitest::Test
  include Rack::Test::Methods

  puts 'Dropping and recreating database...'
  system 'rm -f db/test.sqlite3 && RACK_ENV=test rake db:create db:migrate db:seed > /dev/null'
  puts 'Ok!'

  $id_notes = (1..10).to_a

  def app
    Sinatra::Application
  end
end
