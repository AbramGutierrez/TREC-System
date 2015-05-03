module ConferencesHelper

	def count_shirts(shirt) 

		@shirt_sizes = {
			'XS' => 0,
			'S' => 0,
			'M' => 0,
			'L' => 0,
			'XL' => 0,
			'XXL' => 0
		}

		@conference.teams.each do |team|
			@shirt_sizes[shirt] += team.participants.where("team_id= ? AND shirt_size= ?", team.id, shirt).count
		end
		return @shirt_sizes[shirt]
	end

end
