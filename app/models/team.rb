class Team < ActiveRecord::Base
	belongs_to :conference
	has_many :participants
	validates :conference, :school, :paid_status, 
	  presence: true
	validates :team_name, uniqueness: true , 
	  presence: true
	
	validate :max_team_check
	
	def self.get_active_teams
	  active_conference = Conference.get_active()
	  Team.where(conference_id: active_conference.id)
	end	
	
	def get_captain
	  self.participants.where(captain: true)
	end
	  
	private

		def max_team_check
			if !conference.nil?
				errors.add(:conference, 'There are already the maximum number of teams for the current conference.') unless
					conference.teams.count < conference.max_teams
			end		
		end
end
