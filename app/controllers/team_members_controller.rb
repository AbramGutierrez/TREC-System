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
		# @account = Account.find(params[:id])
		# @account.destroy
		# redirect_to team_members_path
	end
	
end
