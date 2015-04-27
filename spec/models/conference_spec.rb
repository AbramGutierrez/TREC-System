require 'rails_helper'

RSpec.describe Conference, type: :model do
  before(:all) {
    @conference1 = Conference.create!(start_date: Date.parse("2015-6-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing!',
		  is_active: true
		  )
  }
  after(:all) {
    @conference1.destroy
  }
  
  it "should be valid" do
    expect(@conference1).to be_valid
  end
  
  it "should only have one active conference" do  
	conference2 = Conference.create!(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  is_active: true
		  )	
	@conference1.reload		

	expect(@conference1.is_active).to be(false)
	
	expect(conference2.is_active).to be(true)	
  end

  it "should have a start date" do
    expect(Conference.new( 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  )).to_not be_valid	
  end  

  it "should have an end date" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  )).to_not be_valid
  end

  it "should have a max team size" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  )).to_not be_valid
  end

  it "should have a min team size" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  )).to_not be_valid
  end

  it "should have a max teams" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  )).to_not be_valid
  end

  it "should have a tamu cost" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  )).to_not be_valid
  end

  it "should have an other cost" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  challenge_desc: 'testing2!',
		  )).to_not be_valid
  end

  it "should have a challenge description" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  )).to_not be_valid
  end  
  
  it "should have an end date after the start date" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-6-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  is_active: true
		  )).to_not be_valid
  end
  
  it "should have a max team size greater than or equal to the min team size" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 1,
		  min_team_size: 5,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  is_active: true
		  )).to_not be_valid
  end
  
  it "should have a max teams of at least 1" do
    expect(Conference.new(start_date: Date.parse("2015-7-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 0,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing2!',
		  is_active: true
		  )).to_not be_valid
  end
  
end
