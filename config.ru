require "./app"
Dir.glob('./app/{models,helpers,controllers,views}/*.rb').each { |file| require file }
run Sinatra::Application
