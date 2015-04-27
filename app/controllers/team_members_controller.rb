class TeamMembersController < ApplicationController

	def index
	end

	def show
		@participants = Participant.where(:team_id => params[:id])
		#@accounts = Accounts.all(:joins => :participant, :conditions => { :participant => { :team_id => params[:id] } })

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
	
end
