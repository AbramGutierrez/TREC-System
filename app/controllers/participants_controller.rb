class ParticipantsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_or_admin, only: [:show, :edit, :update]
  before_action :admin_account, only: [:index, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /participants
  # GET /participants.json
  def index
	account = Account.find_by(id: session[:account_id])
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
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
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
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	    flash[:error] = "No such participant exists."	
	    redirect_to action: "index"  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:captain, :waiver_signed, :shirt_size, :phone, 
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
end
