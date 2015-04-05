class Account < ActiveRecord::Base
	belongs_to :user, :polymorphic => true
	
	validates :user, presence: true
	
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	#has_secure_password
	#validates :password, length: { minimum: 6 }	
end
