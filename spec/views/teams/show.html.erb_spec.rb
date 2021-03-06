require 'rails_helper'

RSpec.describe "teams/show", type: :view do
  before(:each) do
    c = Conference.create(start_date: Date.parse("2015-4-4"), 
	  end_date: Date.parse("2015-6-6"),
	  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 5,
	  tamu_cost: 30.00,
	  other_cost: 60.00,
	  challenge_desc: 'yay!',
	  created_at: DateTime.parse("2015-4-3"),
	  updated_at: DateTime.parse("2015-4-3"),
	  is_active: true
	  )
    @team = assign(:team, Team.create!(
      :team_name => "MyString",
      :paid_status => "MyString",
      :school => "MyString",
	  :conference => c
    ))
	@p = Participant.create!(captain: false, shirt_size: "L",
			phone: "1876543211", :phone_provider => "3 River Wireless", phone_email: "1876543211@utext.com", account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "password", password_confirmation: "password"}, team: @team)
	log_in_as(@p.account)		
  end
  
  after(:each) do
    @p.destroy
  end
  
  after(:all) do
		first = Conference.first
		first.is_active = true
		first.save!
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Team name/)
    expect(rendered).to match(/Paid status/)
    expect(rendered).to match(/School/)
  end
end
