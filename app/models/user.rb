class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable, :confirmable
		 
	has_many :wikis
	
	scope :visible_to, -> (user) { user ? all : where(public: true) }
	
	def premium?
		role == 'premium'
	end

		 
end
