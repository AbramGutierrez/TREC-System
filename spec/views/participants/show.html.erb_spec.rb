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
	  :phone_provider => "3 River Wireless",
	  :phone_email => "1111111111@messaging.sprintpcs.com",
	  :account_attributes => {
	    email: "test@example.com",
		password: "password",
		first_name: "hello",
		last_name: "world"
	  }
    ))
	
	@admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "password", password_confirmation: "password"}) 
  end
  
  after(:all) do
    @admin.destroy
    @c.destroy
	@new_team.destroy
	@participant.destroy
	first = Conference.first
		first.is_active = true
		first.save!
  end

  it "renders attributes in <p>" do
    log_in_as(@admin.account)
	render
    # expect(rendered).to include(/true/)
    # expect(rendered).to include(/false/)
    # expect(rendered).to include(/L/)
	# expect(rendered).to match(/1111111111/)
  end
end
