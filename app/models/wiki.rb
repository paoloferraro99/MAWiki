class Wiki < ActiveRecord::Base
	
	belongs_to :user
	
	# default_scope :order => 'wiki.title ASC'

   has_many :collaborations
   has_many :users, through: :collaborations

	
end
