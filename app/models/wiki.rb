class Wiki < ActiveRecord::Base
	
	belongs_to :user
	
	# default_scope :order => 'wiki.title ASC'

   has_many :collaborations
   has_many :users, through: :collaborations


   # validates :title, length: { minimum: 5 }, presence: true
   # validates :outline, length: { minimum: 10 }, presence: true
   # validates :body, length: { minimum: 20 }, presence: true
   # validates :user, presence: true

	
end
