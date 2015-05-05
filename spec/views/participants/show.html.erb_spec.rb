require 'rails_helper'

RSpec.describe "participants/show", type: :view do
  before(:all) do
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
  
    @new_team = Team.create!(:conference => @c,	
	  :school => "TestSchool",
	  :paid_status => "paid", 
	  :team_name => "ParticipantShowTeam" 
	  )
    @participant = assign(:participant, Participant.create!(
	  :team => @new_team,
      :captain => true,
      :waiver_signed => false,
      :shirt_size => "L",
	  :phone => "1111111111",
	  :phone_email => "1111111111@messaging.sprintpcs.com",
	  :account_attributes => {
	    email: "test@example.com",
		password: "password",
		first_name: "hello",
		last_name: "world"
	  }
    ))
  end
  
  after(:all) do
    @c.destroy
	@new_team.destroy
	@participant.destroy
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/true/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/L/)
	# expect(rendered).to match(/1111111111/)
  end
end
