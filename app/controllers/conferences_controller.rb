class ConferencesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_conference, only: [:show, :edit, :update, :destroy]
  before_action :show_security, only: :show
  before_action :admin_account, only: [:index, :new, :edit, :create, :update, :destroy]

  # GET /conferences
  # GET /conferences.json
  def index
    @conferences = Conference.all
  end

  # GET /conferences/1
  # GET /conferences/1.json
  def show
  end

  # GET /conferences/new
  def new
    @conference = Conference.new
  end

  # GET /conferences/1/edit
  def edit
  end

  # POST /conferences
  # POST /conferences.json
  def create
    @conference = Conference.new(conference_params)

    respond_to do |format|
      if @conference.save
        format.html { redirect_to @conference, notice: 'Conference was successfully created.' }
        format.json { render :show, status: :created, location: @conference }
      else
        format.html { render :new }
        format.json { render json: @conference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conferences/1
  # PATCH/PUT /conferences/1.json
  def update
    respond_to do |format|
      if @conference.update(conference_params)
        format.html { redirect_to @conference, notice: 'Conference was successfully updated.' }
        format.json { render :show, status: :ok, location: @conference }
      else
        format.html { render :edit }
        format.json { render json: @conference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conferences/1
  # DELETE /conferences/1.json
  def destroy
    @conference.destroy
    respond_to do |format|
      format.html { redirect_to conferences_url, notice: 'Conference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conference
      @conference = Conference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conference_params
      params.require(:conference).permit(:start_date, :end_date, :conf_start_date, :conf_end_date, :max_team_size, :min_team_size, :max_teams, :tamu_cost, :other_cost, :challenge_desc, :is_active)
    end
	
	# Only let a user see the "show" for a conference if the user is an admin or if it is the current conference
	def show_security
	  redirect_to(root_url) unless @conference.is_active? || current_account.user.is_a?(Administrator)
	end
end
