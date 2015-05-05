require 'rails_helper'

RSpec.describe "friendly forwarding", :type => :request do
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

    before(:each) do
		@p = Participant.create!(captain: false, shirt_size: "L",
			phone: "1876543211", phone_email: "1876543211@utext.com",
			team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "password", password_confirmation: "password"})
	end
	
	after(:each) do
		@p.destroy
	end
	
	after(:all) do
		@team.destroy
		@c.destroy
	end
	
	it 'user is properly redirected with friendly forwarding' do

		get edit_account_path(@p.account)
	    expect(response).to redirect_to(login_path)
	    log_in_as(@p.account)
	    expect(response).to redirect_to(edit_account_path(@p.account))
	end
end