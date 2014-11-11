class Wiki < ActiveRecord::Base
	
	belongs_to :user
	
	# default_scope :order => 'wiki.title ASC'

	
end
