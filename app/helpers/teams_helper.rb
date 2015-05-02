module TeamsHelper

	def get_schools_array
		schools_array = Array.new
		if School.count > 0
			schools_array = School.all.map { |school| [school.name] }
		end
		schools_array.push("Other")
		schools_array
	end

	def get_school
	    @school_value
		School.all.each do |school|
			if (school.name == @team.school)
				@school_value = @team.school
			end	
		end
		if @school_value.nil?
			@school_value = "Other"
			@other_value = @team.school
		end
	end

end
