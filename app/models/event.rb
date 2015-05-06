class Event < ActiveRecord::Base
	belongs_to :conference
	
	validates :conference, :day, :start_time, :end_time, :event_desc, presence: true
	
	validate :time_check
	
	def sort(events)
	  events.sort { |a,b| a <=> b}
	end
	
	def <=>(another_event)
	  if self.day < another_event.day
	    return -1
	  elsif another_event.day > self.day
	    return 1
	  end
	  
	  if self.start_time < another_event.start_time
	    return -1
	  elsif another_event.start_time < self.start_time
	    return 1
	  end
	  
	  if self.end_time < another_event.end_time
	    return -1
	  elsif another_event.end_time < self.end_time
	    return 1
	  else
	    return 0
	  end
	end
	
	private
	  def time_check
	    if !start_time.nil? && !end_time.nil?
			errors.add(:end_time, "cannot come before the start time.") if end_time < start_time 
		end
	  end
	
end
