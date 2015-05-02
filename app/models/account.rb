class Account < ActiveRecord::Base
	belongs_to :user, :polymorphic => true
	
	# validates :user, presence: true
	
	before_save { self.email = email.downcase }
	after_create { 
	  self.randomize_password()
	  
	  PasswordMailer.welcome_email(self).deliver_now 
	}
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
					  
	validate :name_validation				  
					  
	# This is necessary to create and encrypt the password
	# To suppress the validations that it adds, pass "validations: false" as an argument to it	
	has_secure_password validations: false
	
	#validates :password, length: { minimum: 6 }

	# Temporary work-around
	attr_accessor :password_confirmation	
	
	def name
	  result = String.new
	  if (!first_name.blank? && !last_name.blank?)
	   result = [first_name, last_name].join " "
	  else
	    result = [first_name, last_name].join
	  end
	  result
	end
	

	def randomize_password
	  temp_password = SecureRandom.base64 4
    self.password = temp_password
    self.password_confirmation = temp_password
	self.save
	end

	private
		def name_validation
		  errors.add(:first_name, "first and last name cannot be blank") unless !first_name.blank? || !last_name.blank?
		end

end
