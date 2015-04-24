class Conference < ActiveRecord::Base
	has_many :teams
	has_many :sponsors
	validates :start_date, presence: true
	
	before_save :one_active_conference
	
	
	private
		# Only allow one active conference. Assume that there is
		# at most one active conference currently. If there is an
		# active conference and this new conference is set to active,
		# then make the old one inactive.
		def one_active_conference
			if (self.is_active == true)
				conference = Conference.find_by is_active: true
				if (!conference.nil?)
					conference.is_active = false
					conference.save
				end
			end	
		end
end
