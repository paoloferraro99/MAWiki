class Wiki < ActiveRecord::Base
	
	belongs_to :user

   has_many :collaborations
   has_many :users, through: :collaborations
   # has_and_belongs_to_many :users

	
	# default_scope :order => 'wiki.title ASC'

   def collaborator_names
      user.try(:name)
   end

   def collaborator_names=(name)
      self.user = User.find_by_name(name) if name.present?
   end


   # validates :title, length: { minimum: 5 }, presence: true
   # validates :outline, length: { minimum: 10 }, presence: true
   # validates :body, length: { minimum: 20 }, presence: true
   # validates :user, presence: true

	
end
