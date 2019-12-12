ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'minitest/reporters'
require File.expand_path(File.join(__dir__, '..', 'app.rb'))

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(
    :color => true
  )
]

class Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
