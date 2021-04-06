# frozen_string_literal: true

require 'faker'

include Faker

puts 'Running seed...'

range = case ENV['RACK_ENV']
        when 'development'
          0...100
        else
          0...10
        end

User.create(username: 'admin',
            email: 'admin@gmail.com',
            password: 'admin')

range.each do
  Note.create(title: TvShows::NewGirl.character,
              description: TvShows::NewGirl.quote,
              user_id: 1,
              active: true)
end

puts 'Seed finished.'
