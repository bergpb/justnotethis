ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'minitest/reporters'
require File.expand_path(File.join(__dir__, '..', 'app.rb'))

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(
  color: true
)]

Minitest.after_run{
  puts 'Removing test database...'
  system 'rm -f db/*.sqlite3'
}

class Minitest::Test
  include Rack::Test::Methods

  puts 'Dropping and creating database...'
  system 'rm -f db/*.sqlite3 && RACK_ENV=test rake db:create db:migrate db:seed > /dev/null'
  puts 'Ok!'

  $id_notes = (1..10).to_a

  def app
    Sinatra::Application
  end
end
