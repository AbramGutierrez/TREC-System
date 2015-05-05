require 'rails_helper'

RSpec.describe Participant, type: :model do

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
		expect(Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", phone_email: Participant.create_phone_email("at&t", "1876543211"),
			team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to be_valid
	end
	
	it "should require an account" do
		expect(Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", phone_email: "1876543211@utext.com", 
			team: @team)).to_not be_valid
	end
	
	it "should require a phone number" do
		expect(Participant.new(captain: false, shirt_size: "L",
			team: @team, phone_email: "@utext.com",
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
	
	it "should not allow a phone number that is not 10 digits" do
		expect(Participant.new(captain: false, shirt_size: "L",
				phone: "18765", phone_email: "18765@utext.com", team: @team, 
				account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
				password: "mypassword", password_confirmation: "mypassword"}
			)).to_not be_valid
	end
	
	it "should require a shirt size" do
		expect(Participant.new(captain: false, 
			phone: "1876543211", phone_email: "1876543211@vtext.com",
			team: @team, account_attributes: {first_name: "A", last_name: "Z", 
			  email: "p4@example.com", password: "mypassword", 
			  password_confirmation: "mypassword"})).to_not be_valid
	end
	
	it "should be a valid shirt size" do
		expect(Participant.new(captain: false, shirt_size: "not_a_shirt_size",
			phone: "1876543211", phone_email: "1876543211@vtext.com", team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
	
	it "should require a team" do
		expect(Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", phone_email: "1876543211@vtext.com",
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
  
	it "should not allow the max team size to be exceeded" do
		c1 = Conference.create!(start_date: Date.parse("2015-4-4"), 
			end_date: Date.parse("2015-6-6"),
			conf_start_date: Date.parse("2015-6-8"),
	        conf_end_date: Date.parse("2015-6-9"),
			max_team_size: 1,
			min_team_size: 1,
			max_teams: 5,
			tamu_cost: 30.00,
			other_cost: 60.00,
			challenge_desc: 'yay!',
			)
		
		team1 = Team.create!(:conference => c1,	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "PartTest" 
			)
			
		p1 = Participant.create!(captain: false, shirt_size: "L",
			phone: "1876543211", phone_email: "1876543211@vtext.com", team: team1,
			account_attributes: {first_name: "A", last_name: "Z", email: "parti1@example.com",
			password: "mypassword", password_confirmation: "mypassword"})

		expect(Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", phone_email: "1876543211@vtext.com", team: team1, 
			account_attributes: {first_name: "A", last_name: "Z", email: "parti2@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
			
			
		p1.destroy
		team1.destroy
		c1.destroy
	end
	
	it "should match the first provider and domain" do
	  expect(Participant.get_providers_list()[0]).to eql("3 river wireless")
	  expect(Participant.get_domains_list[0]).to eql("10digitphonenumber@sms.3rivers.net")
	end
	
	it "should match the last provider and domain" do
	  last_index = Participant.get_providers_list().size() - 1
	  expect(Participant.get_providers_list()[last_index]).to eql("west central wireless")
	  expect(Participant.get_domains_list[last_index]).to eql("10digitphonenumber@sms.wcc.net")
	end
	
	it "should extract domain" do
	  expect(Participant.extract_domain("10digitphonenumber@bellmobility.ca")).to eql("bellmobility.ca")
	end
	
	it "should get the right domain for a participant" do
	  expect(Participant.domain("AT&T")).to eql("txt.att.net")
	end
	
	it "should create the right phone email for invalid phone number" do
	  expect(Participant.create_phone_email("Sprint", nil)).to eql("XXXXXXXXXX@messaging.sprintpcs.com")
	end
	
	it "should create the right phone email for valid phone number" do
	  expect(Participant.create_phone_email("Sprint", "1234567899")).to eql("1234567899@messaging.sprintpcs.com")
	end
	
	it "should return nil for nil phone provider" do
    expect(Participant.create_phone_email(nil, nil)).to be_nil
  end
  
  it "should return nil for invalid phone provider" do
    expect(Participant.create_phone_email("Invalid Provider", nil)).to be_nil
  end
  
end
