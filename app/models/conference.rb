class Conference < ActiveRecord::Base
	has_many :teams
	has_many :sponsors
end
