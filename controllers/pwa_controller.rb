# frozen_string_literal: true

get '/manifest.json' do
  File.read(File.join('static', 'manifest.json'))
end

get '/sw.js' do
  File.read(File.join('static', 'sw.js'))
end
