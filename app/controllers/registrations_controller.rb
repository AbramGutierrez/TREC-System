class RegistrationsController < ApplicationController

	def new
	  @conference = Conference.find_by is_active: true
	  #tell user no active conference exists 
	  if(@conference.nil?)
		redirect_to action: "fail" 
	  end
	  if School.count > 1
	    @schools_array = School.all.map { |school| [school.name] }
		@schools_array.push("Other")
	  end	
	end
	
	def create
	  @conference = Conference.find_by is_active: true

	  @team = Team.new(conference_id: @conference.id, 
	    team_name: params[:team][:team_name],
	    paid_status: "unpaid",
	    school: params[:team][:school])
		
	  @participants = Array.new
	  
	  #make sure all team, participants, and accounts are valid before final creation
	  if @team.valid?
	    params[:participants].each_value do |participant|
		  #skip member entries that are left blank
		  unless has_blank(participant)			
				@new_participant = Participant.new(captain: participant[:captain],
				shirt_size: participant[:shirt_size],
				phone: participant[:phone],
				waiver_signed: false,
				team: @team,
				account_attributes: {
				  email: participant[:email],
				  first_name: participant[:first_name],
				  last_name: participant[:last_name]
				})
				#if is a valid participant then try create a account for it
				if @new_participant.valid?
				  @participants.push(@new_participant)
				else
				  flash.now[:alert] = "There was an error with the provided participant information." +
				  " Please make sure that name, email, and phone number are provided for each participant and are in the correct format." 
				  render 'new' and return
				end
		    end
	    end
		
		unless has_captain(@participants)
		  flash.now[:alert] = "A captain is required."
		  render 'new' and return
		end
		#create team
		@team.save
		
	    if @participants.length > @conference.max_team_size 
		  flash.now[:alert] = flash.now[:alert] = "Too many participants."
		  render 'new' and return
	    end
		#create participants
	    @participants.each do |participant|
	      participant.team_id = @team.id
	      participant.save
	    end

		#successfully created a team, a list of participants of that team, 
		#and a list of accounts linked to each participant
	    redirect_to action: "success"
	  else 
	    flash.now[:alert] = "Make sure that school name is filled and please try a different team name."
		render 'new' and return
	  end
	end
	
	def success
	end
	
	def fail
	end
	
	def has_blank(fields)
	  if (fields[:phone].blank? && fields[:first_name].blank? && 
	    fields[:last_name].blank? && fields[:email].blank?) 
	    return true
	  else
		return false
	  end
	end
	
	def has_captain(participants)
	  participants.each do |participant|
	    if(participant.captain == true)
		  return true
	    end
	    return false
	  end
	end
	
    private :has_blank, :has_captain
	
end