module ApplicationHelper

def get_sponsors
   @active_conference = Conference.find_by_is_active(true)
   if @active_conference.nil?
     @sponsors = nil
   else
     @sponsors = @active_conference.sponsors.order("priority")
   end
end
end
