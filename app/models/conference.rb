class Conference < ActiveRecord::Base
	has_many :teams
	has_many :sponsors
	validates :start_date, presence: true
end
