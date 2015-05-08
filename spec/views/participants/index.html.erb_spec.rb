require 'rails_helper'

RSpec.describe "participants/index", type: :view do
	before(:all) do
		@c = Conference.create!(start_date: Date.parse("2015-4-4"), 
		  end_date: Date.parse("2015-6-6"),
		  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'yay!',
		  is_active: true
		  )
	  
		@team = Team.create!(:conference => @c,	
		  :school => "TestSchool",
		  :paid_status => "paid", 
		  :team_name => "PartControllerTest" 
		  )
	end
	
	after(:all) do
		@team.destroy
		@c.destroy
		first = Conference.first
		first.is_active = true
		first.save!
	end

  before(:each) do
    assign(:participants, [
      Participant.create!(
        :captain => true,
        :waiver_signed => true,
        :shirt_size => "S",
		:phone => "1111111111",
		:phone_provider => "3 River Wireless",
		:phone_email => "1111111111@uswestdatamail.com",
		:team => @team,
	    :account_attributes => {
	      email: "test@example.com",
		  password: "password",
		  first_name: "hello",
		  last_name: "world"
	  }
      ),
      Participant.create!(
        :captain => true,
        :waiver_signed => true,
        :shirt_size => "S",
		:phone => "1111111111",
		:phone_provider => "3 River Wireless",
		:phone_email => "1111111111@sms.wcc.net",
		:team => @team,
	    :account_attributes => {
	      email: "test2@example.com",
		  password: "password",
		  first_name: "hello",
		  last_name: "world"
	  }
      )
    ])
  end

  it "renders a list of participants" do
    #render
    # assert_select "tr>td", :text => false.to_s, :count => 2
    #assert_select "tr>td", :text => true.to_s, :count => 4 # 2
    #assert_select "tr>td", :text => "Shirt Size".to_s, :count => 2
  end
end
