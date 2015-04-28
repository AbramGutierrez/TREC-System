require 'rails_helper'

RSpec.describe Participant, type: :model do

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
			:team_name => "PartControllerTest" 
			)
	end
	
	after(:all) do
		@team.destroy
		@c.destroy
	end
  
	it "should be valid" do
		expect(Participant.new(captain: false, shirt_size: "large",
			phone: "1876543211", team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to be_valid
	end
	
	it "should require an account" do
		expect(Participant.new(captain: false, shirt_size: "large",
			phone: "1876543211", team: @team, 
		)).to_not be_valid
	end
	
	it "should require a phone number" do
		expect(Participant.new(captain: false, shirt_size: "large",
			team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
	
	it "should require a shirt size" do
		expect(Participant.new(captain: false, 
			phone: "1876543211", team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
	
	it "should be a valid shirt size" do
		expect(Participant.new(captain: false, shirt_size: "not_a_shirt_size",
			phone: "1876543211", team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
	
	it "should require a team" do
		expect(Participant.new(captain: false, shirt_size: "large",
			phone: "1876543211", 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
  
end
