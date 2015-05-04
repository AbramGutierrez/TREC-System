class ParticipantsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :dashboard, :update, :destroy]
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_or_admin, only: [:show, :edit, :update]
  before_action :admin_account, only: :index
  before_action :team_captain_or_admin, only: :destroy
  before_action :participant_account, only: [:new, :create]
  helper_method :sort_column, :sort_direction

  # GET /participants
  # GET /participants.json
  def index
	@participants = Participant.includes(:team, :account).order(sort_column + " " + 
	  sort_direction).paginate(:page => params[:page], :per_page => 15)
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
	# Admins can add participants to any team,
	# but participants can only add to their own team.
	if is_admin?
		@team_array = Team.all.map { |team| [team.team_name] }
		if @team_array.nil? || @team_array.blank?
			flash[:alert] = "No team available to add participants to."
			redirect_to action: "index" and return
		end
	else
		@team_array = current_participant.team.team_name
	end	
  end

  # GET /participants/1/edit
  def edit
  end
  
  # GET /participant/dashboard
  def dashboard
  end

  # POST /participants
  # POST /participants.json
  def create
    if !params[:team].nil?
	  if !params[:team][:team_name].nil?
        @team = Team.find_by_team_name(params[:team][:team_name])
	  end	
	end  
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
	    if participant_params[:team_id].nil? && !params[:team][:team_name].nil?
	      @participant.team = @team
		  @participant.save
		end
		log_in @participant.account	
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
	    # there can only be one captain per team
	    if @participant.captain == true
		  @participants = Participant.where('participants.id != ? and participants.team_id = ?', 
		    @participant.id, @participant.team_id)
		  @participants.each do |participant|
		    participant.update(:captain => false)
		  end
		end
		if !is_admin?
			log_in @participant.account
		end	
        
		format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    if @participant.captain == true
	  # randomly assign the next captain
	  @next_captain = Participant.where('participants.id != ? and participants.team_id = ?', 
		    @participant.id, @participant.team_id).first
	  #if there is no more participants in a team, then destroy the team
	  if @next_captain.nil?
	    @participant.team.destroy
	  else
	    @next_captain.update(:captain => true)
	  end
	end
	@participant.account.destroy
    @participant.destroy
    respond_to do |format|
	  if is_admin?
        format.html { redirect_to participants_url, notice: 'Participant was successfully deleted.' }
	  else
        format.html { redirect_to "/team_members/#{current_participant.team.id}", notice: 'Participant was successfully deleted.' }
	  end	
      format.json { head :no_content }
    end
  end
  
  def waiver_checklist
    @active_teams = Conference.find_by_is_active(true).teams
	unless @active_teams.nil?
	  @active_teams = @active_teams.order("teams.team_name")
	end
  end
  
  def update_waivers
  
    #ignore unchecked waivers
    @checked_participants = params[:participants].delete_if {|key, value| value["waiver_signed"] == "0"}
	  
	unless @checked_participants.nil?
	  Participant.update(@checked_participants.keys, @checked_participants.values)
	end
	redirect_to participants_url
	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	    flash[:alert] = "No such participant exists."	
	    redirect_to action: "index"  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:captain, :waiver_signed, :shirt_size, :phone, :phone_email, :team_id,
		:account_attributes => [:first_name, :last_name, :email, :password, :password_confirmation])
    end
	
	def correct_user_or_admin
	  redirect_to(root_url) unless current_participant?(@participant) || current_account.user.is_a?(Administrator)
	end
	
	def sort_column
	  %w[teams.team_name accounts.first_name accounts.last_name captain waiver_signed shirt_size 
	    teams.conference_id].include?( params[:sort]) ? params[:sort] : "teams.conference_id"
	end
	
	def sort_direction
	  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
	
	def team_captain_or_admin
	  if !(current_account.user.is_a?(Administrator) || (@participant.team == current_participant.team && current_participant.captain?))
	    flash[:alert] = "Only the team captain can remove team members."
		redirect_to participant_dashboard_path
	  end
	end
end
