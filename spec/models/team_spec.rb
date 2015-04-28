require 'rails_helper'

RSpec.describe Team, type: :model do
  
    before(:all) do
		@c = Conference.create!(start_date: Date.parse("2015-4-4"), 
			end_date: Date.parse("2015-6-6"),
			max_team_size: 6,
			min_team_size: 1,
			max_teams: 5,
			tamu_cost: 30.00,
			other_cost: 60.00,
			challenge_desc: 'yay!',
			)
			
		@team = Team.create!(:conference => @c,	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "Non-unique Name" 
			)	
	end
	
	after(:all) do
		@team.destroy
		@c.destroy
	end
	
	it "should be valid" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "PartControllerTest" 
		)).to be_valid
	end
	
	it "should require conference" do
		expect(Team.new(	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "PartControllerTest" 
		)).to_not be_valid
	end
	
	it "should require school" do
		expect(Team.new(
			:conference => @c,	
			:paid_status => "paid", 
			:team_name => "PartControllerTest" 
		)).to_not be_valid
	end
	
	it "should require paid status" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:team_name => "PartControllerTest" 
		)).to_not be_valid
	end
	
	it "should require team name" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:paid_status => "paid"
		)).to_not be_valid
	end
	
	it "should enforce team name uniqueness" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:team_name => "Non-unique Name" 
		)).to_not be_valid
	end
  
	it "should not allow the number of teams to exceed the max for a conference" do
		c1 = Conference.create!(start_date: Date.parse("2015-4-4"), 
			end_date: Date.parse("2015-6-6"),
			max_team_size: 6,
			min_team_size: 1,
			max_teams: 1,
			tamu_cost: 30.00,
			other_cost: 60.00,
			challenge_desc: 'yay!',
			)
			
		team = Team.create!(:conference => c1,	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "team1" 
			)
			
		expect(Team.new(
			:conference => c1,	
			:school => "TestSchool",
			:paid_status => "paid",
			:team_name => "team2" 
		)).to_not be_valid
	end
  
end
