class TeamMembersController < ApplicationController
	before_action :team_captain_or_admin, only: [:show, :destroy]
	
	def index
	end

	def show
		@participants = Participant.where(:team_id => params[:id])
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end
	
	def team_captain_or_admin
	  if !(current_account.user.is_a?(Administrator) || (current_participant.team.id.to_s == params[:id].to_s && current_participant.captain?))
	    flash[:alert] = "Only the team captain can add and remove team members."
		redirect_to participant_dashboard_path
	  end
	end
	
end
