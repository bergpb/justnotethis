class Task < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :title, message: 'Title can\'t be blank'
	validates_presence_of :description, message: 'Description can\'t be blank'
	validates_presence_of :user_id, message: 'User can\'t be blank'
	validates_length_of :title, :minimum => 4, :allow_blank => false, message: 'Title too short'
	validates_length_of :description, :minimum => 5, :allow_blank => false, message: 'Description too short'

end