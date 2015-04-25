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

end
