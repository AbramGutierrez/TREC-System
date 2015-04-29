require 'rails_helper'

RSpec.describe "participants/edit", type: :view do
	before(:all) do
		@c = Conference.create!(start_date: Date.parse("2015-4-4"), 
		  end_date: Date.parse("2015-6-6"),
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
	end
	
  before(:each) do
    @participant = assign(:participant, Participant.create!(
      :captain => true,
      :waiver_signed => false,
      :shirt_size => "Small",
	  :phone => "1111111111",
	  :team => @team,
	  :account_attributes => {
	    email: "test@example.com",
		password: "password",
		first_name: "hello",
		last_name: "world"
	  }
    ))
  end

  it "renders the edit participant form" do
    render

    assert_select "form[action=?][method=?]", participant_path(@participant), "post" do

      # assert_select "input#participant_captain[name=?]", "participant[captain]"

      # assert_select "input#participant_waiver_signed[name=?]", "participant[waiver_signed]"

      # assert_select "input#participant_shirt_size[name=?]", "participant[shirt_size]"
	  
	  # expect(page).has_select?('Shirt size', :options => ['small', 'medium', 'large'])
    end
  end
end
