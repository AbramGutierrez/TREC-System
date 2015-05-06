require 'rails_helper'

RSpec.describe Event, type: :model do
  
		
	it "should be valid" do
		expect(Event.new(
			:day => Date.parse("2015-6-8"),
			:start_time => Time.new(10000),
			:end_time => Time.new(10001),
			:event_desc => "lalalalala")).to be_valid
	end	
end
