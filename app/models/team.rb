class Team < ActiveRecord::Base
	belongs_to :conference
	has_many :participants
	validates :conference, :school, :paid_status, 
	  presence: true
	validates :team_name, uniqueness: true , 
	  presence: true
	  
end
