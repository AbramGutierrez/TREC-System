require 'rails_helper'

RSpec.describe Event, type: :model do

	before(:all){		
	@c = Conference.create!(start_date: Date.parse("2015-4-10"), 
	  end_date: Date.parse("2015-6-12"),
	  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 6,
	  tamu_cost: 20.00,
	  other_cost: 40.00,
	  challenge_desc: 'fun!',
	  is_active: true
	  )	
	  }
	  
	  after(:all) { 
		@c.destroy 
		first = Conference.first
		first.is_active = true
		first.save!
	  }
  
		
	it "should be valid" do
		expect(Event.new(
			:conference => @c,
			:day => Date.parse("2015-6-8"),
			:start_time => Time.new(2015, 10, 31, 2, 2, 2, "+02:00"),
			:end_time => Time.new(2015, 11, 31, 3, 3, 3, "+03:00"),
			:event_desc => "lalalalala")).to be_valid
	end	
end
