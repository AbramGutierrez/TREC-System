class ParticipantsController < ApplicationController
  #before_action :set_participant, only: [:show, :edit, :update, :destroy]

  # GET /participants
  # GET /participants.json
  def index
	current_account = Account.find_by(id: session[:account_id])
	if current_account.nil?
	   flash[:error] = "You need to be logged in."	
	   redirect_to root_url  
	elsif is_administrator(current_account) 
	  @participants = Participant.all
	else 
	  #TODO:show participant-view
	  flash[:error] = "try logging in as administrator."	
      redirect_to root_url  
	end
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    current_account = Account.find_by(id: session[:account_id])
    if current_account.nil?
	   flash[:error] = "You need to be logged in."	
	   redirect_to root_url  
	elsif (!is_administrator(current_account) && 
      (current_account.user_id != params[:id]))
	  flash[:error] = "You are not authorized to view."	
	  redirect_to action: "index"  
	else 
	  set_participant 
	end
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
      params.require(:participant).permit(:captain, :waiver_signed, :shirt_size, :phone)
    end
	
	def is_administrator(account)
	    if account.user_type == "Administrator"
	      return true
	    else
	      return false
	    end
	end
end
