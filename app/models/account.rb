class Account < ActiveRecord::Base
	belongs_to :user, :polymorphic => true
	
	before_save { self.email = email.downcase }
	before_validation {
		# If this is a new record and there is no password,
		# then generate a random password that will be emailed to
		# the user.
		if self.password.nil? && self.new_record?	
			self.randomize_password()
		end
	}	
		
	after_create {   
	  PasswordMailer.welcome_email(self).deliver_now 
	}
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX }
					  
	validate :name_validation
    validate :unique_email	
					  
	has_secure_password
	
	validates :password, length: { minimum: 4 }, allow_blank: true	
	
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
	# self.save
	end
	
	def self.get_accounts(users)
	  accounts = Array.new
	  users.each do |user|
	    accounts.push(user.account)
	  end
	  accounts
	end

	private
		def name_validation
		  errors.add(:first_name, "first and last name cannot be blank") unless !first_name.blank? || !last_name.blank?
		end
		
		# Do not allow accounts to be created with an email that is an admin
		# email or an email that is being used in the active conference.
		def unique_email
		    self.email = email.downcase
			if !self.email.nil?
				Administrator.all.each do |admin|
					if !admin.nil? && !admin.account.nil?
						if admin.account.email == self.email && admin.account != self
							errors.add(:email, "is already taken.")
						end
					end
				end
				conference = Conference.find_by is_active: true
				if !conference.nil?
					conference.teams.each do |t|
						t.participants.each do |participant|
							if !participant.nil? && !participant.account.nil?
								if participant.account.email == self.email && participant.account != self
									errors.add(:email, "is already taken.")
								end
							end
						end
					end
				end
			end
		end

end
