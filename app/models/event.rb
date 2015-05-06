class Event < ActiveRecord::Base
	belongs_to :conference
	
	validates :conference, :day, :start_time, :end_time, :event_desc, presence: true
	
	validate :time_check
	
	def sort(events)
	  events.sort { |a,b|
	    if a.day < b.day
        return -1
      elsif b.day > a.day
        return 1
      end
      
      if a.start_time < b.start_time
        return -1
      elsif b.start_time < a.start_time
        return 1
      end
      
      if a.end_time < b.end_time
        return -1
      elsif b.end_time < a.end_time
        return 1
      else
        return 0
      end
	    }
	end
	
	def compare(a, b)
	  if a.day < b.day
	    return -1
	  elsif b.day > a.day
	    return 1
	  end
	  
	  if a.start_time < b.start_time
	    return -1
	  elsif b.start_time < a.start_time
	    return 1
	  end
	  
	  if a.end_time < b.end_time
	    return -1
	  elsif b.end_time < a.end_time
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
