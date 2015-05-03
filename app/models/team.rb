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
			if !conference.nil? && self.new_record?
				errors.add(:conference, 'already has the maximum number of teams.') unless
					conference.teams.count < conference.max_teams
			end		
		end
end
