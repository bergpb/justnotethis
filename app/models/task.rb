class Task < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :title,
	  :allow_blank => false,
	  message: "Title can't be blank"
	validates_presence_of :description,
	  :allow_blank => false,
	  message: "Description can't be blank"
	validates_presence_of :user_id,
	  message: "User can't be blank"
	validates_length_of :title,
	  :minimum => 4,
	  :allow_blank => false,
	  message: "Title can't be less than 4 caracters"
	validates_length_of :description,
	  :minimum => 6,
	  :allow_blank => false,
	  message: "Description can't be less than 6 caracters"

end