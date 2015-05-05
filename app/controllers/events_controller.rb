class EventsController < ApplicationController
  
  def show_itinerary
	conference = Conference.find_by is_active: true
	if conference.events.nil?
		@itinerary = []
	else
		@itinerary = conference.events
	end
  end
  
  
  def edit_itinerary
	conference = Conference.find_by is_active: true
	if conference.events.nil?
		@itinerary = []
	else
		@itinerary = conference.events
	end
  end
  
  
  def create
    @event = event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @edit_itinerary, notice: 'Event was successfully created.' }
      else
        format.html { render :edit_itinerary }
      end
    end
  end
  
  
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @edit_itinerary, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit_itinerary }
      end
    end
  end
  
  
  private
	def event_params
	  params.require(:event).permit(:start_time, :end_time, :event_desc)
    end
	
	
end
