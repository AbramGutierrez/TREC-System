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
  
  private
	def event_params
	  params.require(:event).permit(:start_time, :end_time, :event_desc)
    end
	
	
end
