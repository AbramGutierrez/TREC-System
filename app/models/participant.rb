class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	
	validates :phone, :account, :team, presence: true
	validates :shirt_size, presence: true, inclusion: { in: %w(XS S M L XL),
      message: "%{value} is not a valid size, try entering XS, S, M, L, or XL." }
	  
	# Apparently Ruby views nil and false as the same thing, so this only allows captain to be true
	# validates :captain, presence: true
	
	# We could do something like this, but it is not necessary
	validates :captain, inclusion: [true, false]
	
	validate :team_full
	
	accepts_nested_attributes_for :account
	
	private
	
		def team_full
			if !team.nil?
				errors.add(:team, "already has the maximum number of participants.") unless
					team.participants.count < team.conference.max_team_size
			end		
		end
end
