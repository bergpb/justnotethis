require 'faker'

include Faker

puts 'Running migrations...'

User.create(username: 'admin' , email: 'admin@gmail.com', password: 'admin')

(0...200).each do
  Task.create(title: NewGirl.character , description: NewGirl.quote , user_id: 1, active: true)
end

Tag.create(tag: 'lisapi')
Tag.create(tag: 'justdoit')
Tag.create(tag: 'study')
Tag.create(tag: 'see-later')

Tagging.create(tag_id: 1, task_id: 1)
Tagging.create(tag_id: 2, task_id: 1)
Tagging.create(tag_id: 3, task_id: 1)
Tagging.create(tag_id: 4, task_id: 1)

puts "Seed finished."
