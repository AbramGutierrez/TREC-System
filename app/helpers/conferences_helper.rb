module ConferencesHelper

	def count_shirts(shirt) 

		@shirt_sizes = {
			'X-small' => 0,
			'Small' => 0,
			'Medium' => 0,
			'Large' => 0,
			'X-large' => 0
		}

		@conference.teams.each do |team|
			@shirt_sizes[shirt] += team.participants.where("team_id= ? AND shirt_size= ?", team.id, shirt).count
		end
		return @shirt_sizes[shirt]
	end

end
