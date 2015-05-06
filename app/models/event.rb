class Event < ActiveRecord::Base
	belongs_to :conference
	
	validates :conference, :day, :start_time, :end_time, :event_desc, presence: true
	
	validate :time_check
	
	private
	  def time_check
	    if !start_time.nil? && !end_time.nil?
			errors.add(:end_time, "cannot come before the start time.") if end_time < start_time 
		end
	  end
	
end
