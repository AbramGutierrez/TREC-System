class RegistrationsController < ApplicationController
	def new
	  @conference = Conference.find_by is_active: true
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
	  if @team.valid?
	    params[:participants].each_value do |participant|
		  unless has_blank(participant)
			  @new_participant = Participant.new(captain: participant[:captain],
				shirt_size: participant[:shirt_size],
				phone: participant[:phone])
				
				if @new_participant.valid?
				  @participants.push(@new_participant)
				  
				  @new_account = Account.new(user: @new_participant,
				  email: participant[:email],
				  first_name: participant[:first_name],
				  last_name: participant[:last_name])
				  
				  if @new_account.valid?
					@accounts.push(@new_account)
				  else
					flash.now[:error] = flash.now[:error] = "account.save error."
					render 'new' and return			  
				  end 
				else
				  flash.now[:error] = flash.now[:error] = "participant.save error."
				  render 'new' and return
				end
		    end
	    end
	  if @participants.length == 0 
		flash.now[:error] = flash.now[:error] = "minimum one captain needed"
		render 'new' and return
	  end
	  @participants.each do |participant| 
	   if participant.captain == true
	     @team.save
	   end
	  end
	  @participants.each do |participant|
	   participant.team_id = @team.id
	   participant.save
	  end
	  @accounts.each do |account|
	   account.save
	  end
	  redirect_to action: "success"
	  else 
	    flash.now[:error] = "team.save error."
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
	
    private :has_blank
	
end
