module RegistrationsHelper

	def get_school_name
	    @school_value = String.new
		@other_value = String.new
		if @team.school.nil? && @team.school.blank?
			if School.count > 0
				@school_value = School.first
			else
				@school_value = "Other"
			end	
			@other_value = ""
		else
			if School.count > 0
				School.all.each do |school|
					if (school.name == @team.school)
						@school_value = @team.school
					end	
				end
				if @school_value.nil?
					@school_value = "Other"
					@other_value = @team.school
				end
			else
				@school_value = "Other"
				@other_value = @team.school
			end	
		end
		return @school_value
	end
	
	def get_other_val
		@other_value
	end

end
