module ApplicationHelper
	def get_sponsors
	  @active_conference = Conference.find_by is_active: true
	  if @active_conference.nil?
	    @sponsors = nil
	  else
	    @sponsors = @active_conference.sponsors.order("priority")
	  end
	end
	
	def get_schools_array
		schools_array = Array.new
		if School.count > 0
			schools_array = School.all.map { |school| [school.name] }
		end
		schools_array.push("Other")
		schools_array
	end
	
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
				if @school_value.blank?
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
	
	def get_other_value
		@other_value
	end
end
