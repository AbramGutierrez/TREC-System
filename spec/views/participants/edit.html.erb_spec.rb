require 'rails_helper'

RSpec.describe "participants/edit", type: :view do
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
		@admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "password", password_confirmation: "password"}) 
	end
	
	after(:all) do
		@admin.destroy
		@team.destroy
		@c.destroy
		first = Conference.first
		first.is_active = true
		first.save!
	end
	
  before(:each) do
    @participant = assign(:participant, Participant.create!(
      :captain => true,
      :waiver_signed => false,
      :shirt_size => "S",
	  :phone => "1111111111",
	  :phone_provider => "3 River Wireless",
	  :phone_email => Participant.create_phone_email("virgin mobile", "1111111111"),
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
	log_in_as(@admin.account)
  
    render

    assert_select "form[action=?][method=?]", participant_path(@participant), "post" do

      # assert_select "input#participant_captain[name=?]", "participant[captain]"

      # assert_select "input#participant_waiver_signed[name=?]", "participant[waiver_signed]"

      # assert_select "input#participant_shirt_size[name=?]", "participant[shirt_size]"
	  
	  # expect(page).has_select?('Shirt size', :options => ['small', 'medium', 'large'])
    end
  end
end
