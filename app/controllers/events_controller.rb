class EventsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :admin_account, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
	conference = Conference.find_by is_active: true
	if conference.nil? || conference.events.nil?
		@events = []
	else
		@events = conference.events
		@events = Event(@events)
	end
  end

  def itinerary
    conference = Conference.find_by is_active: true
	if conference.nil? || conference.events.nil?
		@events = []
	else
		@events = conference.events
		@events = Event.sort(@events)
	end
  end
  
  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    conference = Conference.find_by is_active: true
    # @event = Event.new(
		# :conference => conference,
		# :day => params[:event][:day],
		# :start_time => params[:event][:start_time], 
		# :end_time => params[:event][:end_time], 
		# :event_desc => params[:event][:event_desc]
	# )
	new_params = event_params
	if !conference.nil?
		new_params[:conference] = conference
	end
	@event = Event.new(new_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:day, :start_time, :end_time, :event_desc)
    end
end
