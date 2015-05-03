require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe "validates that it" do
      before(:each) do
  		@administrator = Administrator.new(account_attributes: {first_name: "first", last_name: "last",
  								email: "valid_email@test.com", password: "123456",
  								password_confirmation: "123456"})
      end
  	
  	it "should be valid" do
  		expect(@administrator).to be_valid
  	end
  	
  	it "should require an account" do
  		expect(
  			Administrator.new()
  		).to_not be_valid
  	end
  end
  	
  	describe "when it sends a message" do
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
           @inactive_team2 = Team.create!(:conference => @inactive_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team2" 
            )
            @inactive_team3 = Team.create!(:conference => @inactive_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team3" 
            )
           @active1 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team4" 
            )
           @active2 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team5" 
            )
           @active3 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team6" 
            )
            @captain = Participant.create!(captain: true, shirt_size: "S",
              phone: "1876543211", team: @active2, 
              account_id: Account.create!(first_name: "A", last_name: "Z", email: "p1@example.com",
              password: "mypassword", password_confirmation: "mypassword").id
              )
             @not_captain1 = Participant.create!(captain: false, shirt_size: "XL",
              phone: "3009098512", team: @active2, 
              account_id: Account.create!(first_name: "A", last_name: "Z", email: "p2@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @not_captain2 = Participant.create!(captain: false, shirt_size: "XL",
              phone: "8133614073", team: @active2, 
              account_id: Account.create!(first_name: "A", last_name: "Z", email: "p3@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @not_captain3 = Participant.create!(captain: false, shirt_size: "M",
              phone: "9642752086", team: @active2, 
              account_id: Account.create!(first_name: "A", last_name: "Z", email: "p4@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @other_team_captain = Participant.create!(captain: true, shirt_size: "M",
              phone: "4296814083", team: @active3, 
              account_id: Account.create!(first_name: "A", last_name: "Z", email: "p5@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @other_team_not_captain = Participant.create!(captain: false, shirt_size: "S",
              phone: "7282822361", team: @active3, 
              account_id: Account.create!(first_name: "A", last_name: "Z", email: "p6@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
        end
      
       after(:all) do
        @inactive_conference.destroy
        @active_conference.destroy
        @inactive_team1.destroy
        @inactive_team2.destroy
        @inactive_team3.destroy
        @active1.destroy
        @active2.destroy
        @active3.destroy
        @captain.destroy
        @not_captain1.destroy
        @not_captain2.destroy
        @not_captain3.destroy
        @other_team_captain.destroy
        @other_team_not_captain.destroy
      end
      
      it "should get all participant recipients" do
        expect(Administrator.get_recipients(
          Administrator.recipient_participant)).to match_array(
          [@captain, @not_captain1, @not_captain2, @not_captain3, 
            @other_team_captain, @other_team_not_captain])
      end
      
      it "should get all captain recipients" do
        expect(Administrator.get_recipients(
          Administrator.recipient_captain)).to match_array(
          [@captain, @other_team_captain])
      end
      
      it "should get email addresses of given users" do
        recipients = Administrator.get_recipients(Administrator.recipient_participant)
        expect(Administrator.get_message_addresses(
          recipients, Administrator.method_email)).to match_array(
          [@captain.account.email, @not_captain1.account.email, 
            @not_captain2.account.email, @not_captain3.account.email, 
            @other_team_captain.account.email, @other_team_not_captain.account.email])
      end
  	
  	
		it "should get phone numbers of given users" do
		  recipients = Administrator.get_recipients(Administrator.recipient_participant)
			expect(Administrator.get_message_addresses(
			  recipients, Administrator.method_text_message)).to match_array(
			  ["1876543211@txt.att.net", "3009098512@txt.att.net", 
				"8133614073@txt.att.net", "9642752086@txt.att.net", 
				"4296814083@txt.att.net", "7282822361@txt.att.net"])
		end
	end
end
