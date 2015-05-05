class SponsorsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_sponsor, only: [:show, :edit, :update, :destroy]
  before_action :set_conference, only: [:new, :edit, :create, :update]
  before_action :admin_account, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  # GET /sponsors
  # GET /sponsors.json
  def index
    @sponsors = Sponsor.all
  end

  # GET /sponsors/1
  # GET /sponsors/1.json
  def show
  end

  # GET /sponsors/new
  def new
    @sponsor = Sponsor.new
	if @conference_array.nil? || @conference_array.blank?
	  flash[:error] = "No conference available to add sponsor to. Please add a conference first."
	  redirect_to action: "index" and return
	end
  end

  # GET /sponsors/1/edit
  def edit
  end

  # POST /sponsors
  # POST /sponsors.json
  def create
    @conference = Conference.find_by_start_date(params[:sponsor][:conference])
    @sponsor = Sponsor.new(:conference => @conference,
	  :website_url => params[:sponsor][:website_url],
	  :sponsor_name => params[:sponsor][:sponsor_name],
	  :logo_path => params[:sponsor][:logo_path],
	  :priority => params[:sponsor][:priority]
	)

    respond_to do |format|
      if @sponsor.save
        format.html { redirect_to @sponsor, notice: 'Sponsor was successfully created.' }
        format.json { render :show, status: :created, location: @sponsor }
      else
        format.html { render :new }
        format.json { render json: @sponsor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sponsors/1
  # PATCH/PUT /sponsors/1.json
  def update
    @conference = Conference.find_by_start_date(params[:sponsor][:conference])
    respond_to do |format|
      if @sponsor.update(:conference => @conference,
	    :sponsor_name => params[:sponsor][:sponsor_name],
	    :logo_path => params[:sponsor][:logo_path],
	    :priority => params[:sponsor][:priority]
	  )
        format.html { redirect_to @sponsor, notice: 'Sponsor was successfully updated.' }
        format.json { render :show, status: :ok, location: @sponsor }
      else
        format.html { render :edit }
        format.json { render json: @sponsor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsors/1
  # DELETE /sponsors/1.json
  def destroy
    @sponsor.logo_path.delete_empty_dirs
    @sponsor.destroy
    respond_to do |format|
      format.html { redirect_to sponsors_url, notice: 'Sponsor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsor
      @sponsor = Sponsor.find(params[:id])
    end
	def set_conference
      @conference_array = Conference.all.map { |conference| [conference.start_date] }
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def sponsor_params
      params.require(:sponsor).permit(:conference, :conference_id, :sponsor_name, :logo_path, :priority)
    end
end
