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
	  Team.joins(:conference).group(active_conference.id)
	end	
	
	def get_participants
	  Participants.joins(:team).group(:id)
	end
	
	def get_captains
	  Participants.joins(:team).group(:id).where(:captain)
	end
	  
	private

		def max_team_check
			if !conference.nil?
				errors.add(:conference, 'There are already the maximum number of teams for the current conference.') unless
					conference.teams.count < conference.max_teams
			end		
		end
end
