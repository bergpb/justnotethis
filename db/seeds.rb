require 'faker'

include Faker

puts 'Running seed...'

case ENV["RACK_ENV"]
when 'development'
  range = 0...100
else
  range = 0...10
end

User.create(username: 'admin',
            email: 'admin@gmail.com',
            password: '123456')

range.each do
  Note.create(title: TvShows::NewGirl.character,
              description: TvShows::NewGirl.quote,
              user_id: 1,
              active: true)
end

puts "Seed finished."
