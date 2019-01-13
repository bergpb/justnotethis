class User < ActiveRecord::Base
  has_secure_password
  
	has_many :tasks
	
	validates_presence_of :username, :allow_blank => false, message: 'Username can\'t be blank'
	validates_presence_of :email, :allow_blank => false, message: 'Password can\'t be blank'
	validates_presence_of :password, length: { minimum: 6 }, :allow_blank => false,  message: 'Password can\'t be less than 6 caracters'
	validates_uniqueness_of :email
	validates_length_of :username, :minimum => 4, :allow_blank => false, message: 'Title too short'
end
