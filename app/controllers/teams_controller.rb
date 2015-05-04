class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :admin_account, only: [:index, :destroy, :new, :create]
  # before_action :participant_account, only: [:new, :create]
  before_action :on_team_or_admin, only: :show
  before_action :captain_or_admin, only: [:edit, :update]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
	new_params = team_params
	if team_params[:school] == "Other"
	  new_params[:school] = params[:team_name][:other]
	end
	@team = Team.new(new_params) 

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    new_params = team_params
	if team_params[:school] == "Other"
	  new_params[:school] = params[:team_name][:other]
	end	
    respond_to do |format|
      if @team.update(new_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:conference, :conference_id, :team_name, :paid_status, :school, :other)
    end
	
	# Ensure that the currently logged-in participant is on the current team
	def on_team
	  redirect_to(root_url) unless current_account.user.is_a?(Participant) && current_participant.team == @team
	end
	
	def on_team_or_admin
	  redirect_to(root_url) unless (current_account.user.is_a?(Participant) && 
		current_participant.team == @team) || current_account.user.is_a?(Administrator)	
	end	
	
	def captain_or_admin
		if !(current_account.user.is_a?(Administrator))
			# if not team captain
			if !(current_account.user.is_a?(Participant) && 
				current_participant.team == @team && current_participant.captain?)
				flash[:alert] = "Only the Team Captain can edit team information."
				redirect_to(participant_dashboard_url)
			else
				# if team captain but conference has already begun
				if @team.conference.conf_start_date <= Date.parse(Time.now.to_s)
					flash[:alert] = "Team information cannot be edited during the conference."
					redirect_to(participant_dashboard_url)
				end
			end	
		end
	
	  # if !((current_account.user.is_a?(Participant) && 
		# current_participant.team == @team && current_participant.captain?) || 
		# current_account.user.is_a?(Administrator))
		  # flash[:alert] = "Only the Team Captain can edit team information."
		  # redirect_to(root_url)
	  # end		
	end
end
