class RegistrationsController < ApplicationController

	def new
	  @conference = Conference.find_by is_active: true
	  #tell user no active conference exists 
	  if(@conference.nil?)
		redirect_to action: "fail" 
	  end
	end
	
	def create
	  @conference = Conference.find_by is_active: true
	  
	  @team = Team.new(conference_id: @conference.id, 
	    team_name: params[:team][:team_name],
	    paid_status: "unpaid",
	    school: params[:team][:school])
		
	  @participants = Array.new
	  @accounts = Array.new
	  
	  #make sure all team, participants, and accounts are valid before final creation
	  if @team.valid?
	    params[:participants].each_value do |participant|
		  #skip member entries that are left blank
		  unless has_blank(participant)
			  @new_participant = Participant.new(captain: participant[:captain],
				shirt_size: participant[:shirt_size],
				phone: participant[:phone])
				#if is a valid participant then try create a account for it
				if @new_participant.valid?
				  @participants.push(@new_participant)
				  
				  @new_account = Account.new(user: @new_participant,
				  email: participant[:email],
				  first_name: participant[:first_name],
				  last_name: participant[:last_name])
				
				  if @new_account.valid?
					@accounts.push(@new_account)
				  else
					flash.now[:error] = "There was an error with the provided participant information." +
				  " Please make sure a name and email is provided for each participant and the email is in the same format shown."
					render 'new' and return			  
				  end 
				else
				  flash.now[:error] = "There was an error with the provided participant information." +
				  " Please make sure a phone number is provided and in the same format shown." 
				  render 'new' and return
				end
		    end
	    end
		
		unless has_captain(@participants)
		  flash.now[:error] = "A captain is required."
		  render 'new' and return
		end
		#create team
		@team.save
		
	    if @participants.length > @conference.max_team_size 
		  flash.now[:error] = flash.now[:error] = "Too many participants."
		  render 'new' and return
	    end
		#create participants
	    @participants.each do |participant|
	      participant.team_id = @team.id
	      participant.save
	    end
		#create account
	    @accounts.each do |account|
	      account.save
	    end
		#successfully created a team, a list of participants of that team, 
		#and a list of accounts linked to each participant
	    redirect_to action: "success"
	  else 
	    flash.now[:error] = "Make sure that school name is filled or try a different team name."
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
