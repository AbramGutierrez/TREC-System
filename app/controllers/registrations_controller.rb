class RegistrationsController < ApplicationController
	before_action :active_conference_check, only: [:new, :create]
	before_action :date_check, only: [:new, :create]

	def new
	  @conference = Conference.find_by is_active: true
	  #tell user no active conference exists 
	  # if(@conference.nil?)
		# redirect_to action: "fail" 
	  # end	
	  
	  @team = Team.new
	end
	
	def create
	  @conference = Conference.find_by is_active: true

	  # If the user selected the "other" option in the school name select,
	  # then extract the school name from the text field. Otherwise,
	  # use the value in the select.
	  if params[:team][:school] == "Other"
	    @school = params[:team][:other]
	  else
        @school = params[:team][:school]
      end		

	  @team = Team.new(conference: @conference, 
	    team_name: params[:team][:team_name],
	    paid_status: "unpaid",
	    school: @school)
		
	  @participants = Array.new
	  
	  #make sure all team, participants, and accounts are valid before final creation
	  if @team.valid?
	    params[:participants].each_value do |participant|
		  #skip member entries that are left blank
		  unless has_blank(participant)			
				@new_participant = Participant.new(captain: participant[:captain],
				shirt_size: participant[:shirt_size],
				phone: participant[:phone],
				phone_email: Participant.create_phone_email(participant[:phone_provider],participant[:phone]),
				waiver_signed: false,
				team: @team,
				account_attributes: {
				  email: participant[:email],
				  first_name: participant[:first_name],
				  last_name: participant[:last_name]
				})
				
				if @new_participant.valid?
				  @participants.push(@new_participant)
				else
				  #flash.now[:alert] = "There was an error with the provided participant information." +
				  #" Please make sure that name, email, and phone number are provided for each participant and are in the correct format." 
				  flash.now[:alert] = @new_participant.errors.full_messages.to_sentence
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
		  flash.now[:alert] = "Too many participants."
		  render 'new' and return
	    end
		#create participants
	    @participants.each do |participant|
	      participant.team_id = @team.id
	      participant.save
	    end

		#successfully created a team, a list of participants of that team, 
		#and a list of accounts linked to each participant
		flash[:success] = "You have successfully registered. Check your email for your temporary password."
	    # redirect_to action: "success"
	    redirect_to login_url
	  else 
	    #@participant.errors.
		#flash.now[:alert] = "Make sure that school name is filled or try a different team name."
		flash.now[:alert] = @team.errors.full_messages.to_sentence
		render 'new' and return
	  end
	end
	
	def success
	end
	
	def fail
	end
	
	def has_blank(fields)
	  if (fields[:phone].blank? && fields[:first_name].blank? && 
	    fields[:phone_provider].blank? && fields[:last_name].blank? && fields[:email].blank?) 
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
	  end
	  return false
	end
	
    private :has_blank, :has_captain
	
	def active_conference_check
		@conference = Conference.find_by is_active: true
		#tell user no active conference exists 
		if(@conference.nil?)
			flash[:alert] = "Registration is currently closed."
			redirect_to root_url
		end
	end
	
	def date_check
		@conference = Conference.find_by is_active: true
		if !@conference.nil?
			if Date.parse(Time.now.to_s) < @conference.start_date || 
				@conference.end_date < Date.parse(Time.now.to_s)
				flash[:alert] = "Registration is currently closed."
				redirect_to root_url
			end
		end
	end
	
end