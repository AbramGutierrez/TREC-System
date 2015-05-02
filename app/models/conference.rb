class Conference < ActiveRecord::Base
	has_many :teams
	has_many :sponsors
	validates :start_date, :end_date, :max_team_size, 
		:min_team_size, :max_teams, :tamu_cost, :other_cost,
		:challenge_desc, presence: true
	
	before_save :one_active_conference
	
	validate :date_validation, :team_size_validation, :max_teams_validation
	
	def self.get_active
	  Conference.find_by is_active: true
	end
	
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
		
		def date_validation
		    if (!start_date.nil? && !end_date.nil?)
				errors.add(:end_date, 'cannot be before the start date') if start_date > end_date
			end	
		end
		
		def team_size_validation
			if (!min_team_size.nil? && !max_team_size.nil?)
				errors.add(:max_team_size, 'cannot be less than min team size') if min_team_size > max_team_size
			end	
		end
		
		def max_teams_validation
			if (!max_teams.nil?)
				errors.add(:max_teams, 'cannot be less than 1') if max_teams <= 0
			end
		end
end
