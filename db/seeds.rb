require 'faker'

include Faker

puts 'Running migrations...'

User.create(username: 'admin' , email: 'admin@gmail.com', password: 'admin')

(0...10).each do
  Task.create(title: NewGirl.character , description: NewGirl.quote , user_id: 1, active: true)
end

puts "Finished."

