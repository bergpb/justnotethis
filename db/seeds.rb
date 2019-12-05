require 'faker'
include Faker

puts 'Running seed...'

User.create(username: 'admin',
            email: 'admin@gmail.com',
            password: '123456')

(0...50).each do
  Note.create(title: TvShows::NewGirl.character,
              description: TvShows::NewGirl.quote,
              user_id: 1, active: true)
end

puts "Seed finished."
