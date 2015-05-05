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
			phone: "1876543211", phone_provider: "3 River Wireless",
			team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to be_valid
	end
	
	it "should require an account" do
		expect(Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", phone_provider: "3 River Wireless",
			team: @team)).to_not be_valid
	end
	
	it "should require a phone number" do
		expect(Participant.new(captain: false, shirt_size: "L",
			team: @team, phone_provider: "3 River Wireless",
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
	
	it "should not allow a phone number that is not 10 digits" do
		expect(Participant.new(captain: false, shirt_size: "L",
				phone: "18765", phone_provider: "3 River Wireless", team: @team, 
				account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
				password: "mypassword", password_confirmation: "mypassword"}
			)).to_not be_valid
	end
	
	it "should not allow a phone number that is not digits" do
		expect(Participant.new(captain: false, shirt_size: "L",
				phone: "aaaaaaaaaa", phone_provider: "3 River Wireless", team: @team, 
				account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
				password: "mypassword", password_confirmation: "mypassword"}
			)).to_not be_valid
	end
	
	it "should require a shirt size" do
		expect(Participant.new(captain: false, 
			phone: "1876543211", phone_provider: "3 River Wireless",
			team: @team, account_attributes: {first_name: "A", last_name: "Z", 
			  email: "p4@example.com", password: "mypassword", 
			  password_confirmation: "mypassword"})).to_not be_valid
	end
	
	it "should be a valid shirt size" do
		expect(Participant.new(captain: false, shirt_size: "not_a_shirt_size",
			phone: "1876543211", phone_provider: "3 River Wireless", team: @team, 
			account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}
		)).to_not be_valid
	end
	
	it "should require a team" do
		expect(Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", phone_provider: "3 River Wireless",
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
			phone: "1876543211", phone_provider: "3 River Wireless", team: team1,
			account_attributes: {first_name: "A", last_name: "Z", email: "parti1@example.com",
			password: "mypassword", password_confirmation: "mypassword"})

		expect(Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", phone_provider: "3 River Wireless", team: team1, 
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
  
  describe "when searching" do
      before(:all) do
        @inactive_conference = Conference.create!(start_date: Date.parse("2015-4-4"), 
          end_date: Date.parse("2015-6-6"),
          conf_start_date: Date.parse("2015-1-1"),
          conf_end_date: Date.parse("2015-2-2"),
          max_team_size: 6,
          min_team_size: 1,
          max_teams: 5,
          tamu_cost: 30.00,
          other_cost: 60.00,
          challenge_desc: 'yay!',
          is_active: false
         )
         @active_conference = Conference.create!(start_date: Date.parse("2015-4-4"), 
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
          
          @inactive_team1 = Team.create!(:conference => @inactive_conference, 
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team1" 
            )
           @active2 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team5" 
            )
            @captain = Participant.create!(captain: true, shirt_size: "S",
              phone: "1876543211", team: @active2, phone_provider: "3 River Wireless",
              account: Account.create!(first_name: "A", last_name: "Z", email: "p1@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
             @not_captain1 = Participant.create!(captain: false, shirt_size: "XL",
              phone: "3009098512", team: @active2, phone_provider: "3 River Wireless",
              account: Account.create!(first_name: "A", last_name: "Z", email: "p2@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @not_captain2 = Participant.create!(captain: false, shirt_size: "XL",
              phone: "8133614073", team: @active2, phone_provider: "3 River Wireless",
              account: Account.create!(first_name: "A", last_name: "Z", email: "p3@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @not_captain3 = Participant.create!(captain: false, shirt_size: "M",
              phone: "9642752086", team: @active2, phone_provider: "3 River Wireless",
              account: Account.create!(first_name: "A", last_name: "Z", email: "p4@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @inactive_captain = Participant.create!(captain: true, shirt_size: "S",
              phone: "7282822361", team: @inactive_team1, phone_provider: "3 River Wireless",
              account: Account.create!(first_name: "A", last_name: "Z", email: "p7@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @inactive_person = Participant.create!(captain: false, shirt_size: "S",
              phone: "9999999999", team: @inactive_team1, phone_provider: "3 River Wireless",
              account: Account.create!(first_name: "A", last_name: "Z", email: "p8@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
        end
      
       after(:all) do
        @inactive_conference.destroy
        @active_conference.destroy
        @inactive_team1.destroy
        @active2.destroy
        @captain.destroy
        @not_captain1.destroy
        @not_captain2.destroy
        @not_captain3.destroy
        @inactive_captain.destroy
        @inactive_person.destroy
      end
      
      it "should get all active participants" do
        expect(Participant.get_active).to match_array([@captain, @not_captain1, @not_captain2, @not_captain3])
      end
  end
  
end
