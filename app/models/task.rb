class Task < ActiveRecord::Base
	belongs_to :user
	has_many :taggings
  has_many :tags, through: :taggings, :source => :tag
	
	validates_presence_of :title, message: 'Title can\'t be blank'
	validates_presence_of :description, message: 'Description can\'t be blank'
	validates_presence_of :user_id, message: 'User can\'t be blank'
	validates_length_of :title, :minimum => 4, :allow_blank => false, message: 'Title too short'
	validates_length_of :description, :minimum => 5, :allow_blank => false, message: 'Description too short'
	
	def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end