class EventsController < ApplicationController
  
  def show_itinerary
	@itinerary = @conference.events.all
  end

  def edit_itinerary
	@itinerary = @conference.events.all
  end
  
  private
	def event_params
	  params.require(:event).permit(:start_time, :end_time, :event_desc)
    end
	
end
