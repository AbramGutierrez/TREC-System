class Account < ActiveRecord::Base
	belongs_to :user, :polymorphic => true
	
	validates :user, presence: true
	
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
					  
	# This is necessary to create and encrypt the password
	# To suppress the validations that it adds, pass "validations: false" as an argument to it	
	has_secure_password validations: false
	
	#validates :password, length: { minimum: 6 }

	# Temporary work-around
	attr_accessor :password_confirmation	
	
	def name
	  [first_name, last_name].join " "
	end
end
