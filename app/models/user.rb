class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable, :confirmable
		 
	has_many :collaborations
	has_many :wikis, through: :collaborations

	
	scope :visible_to, -> (user) { user ? all : where(public: true) }
	
	# def free?
	# 	role == 'free'
	# end

	def premium?
		role == 'premium'
	end

	
	def self.all_except(user)
    	where.not(id: user)
 	 end

		 
end
