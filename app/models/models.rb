class Task < ActiveRecord::Base
	belongs_to :user
end

class User < ActiveRecord::Base
  has_secure_password
	has_many :tasks
end
