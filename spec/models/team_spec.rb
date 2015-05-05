require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "the model validates that it" do
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
			is_active: false
			)
			
		@team = Team.create!(:conference => @c,	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "Non-unique Name" 
			)	
	end
	
	after(:all) do
		@team.destroy
		@c.destroy
	end
	
	it "should be valid" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "PartControllerTest" 
		)).to be_valid
	end
	
	it "should require conference" do
		expect(Team.new(	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "PartControllerTest" 
		)).to_not be_valid
	end
	
	it "should require school" do
		expect(Team.new(
			:conference => @c,	
			:paid_status => "paid", 
			:team_name => "PartControllerTest" 
		)).to_not be_valid
	end
	
	it "should require paid status" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:team_name => "PartControllerTest" 
		)).to_not be_valid
	end
	
	it "should require team name" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:paid_status => "paid"
		)).to_not be_valid
	end
	
	it "should enforce team name uniqueness" do
		expect(Team.new(
			:conference => @c,	
			:school => "TestSchool",
			:team_name => "Non-unique Name" 
		)).to_not be_valid
	end
  
	it "should not allow the number of teams to exceed the max for a conference" do
		c1 = Conference.create!(start_date: Date.parse("2015-4-4"), 
			end_date: Date.parse("2015-6-6"),
			conf_start_date: Date.parse("2015-6-8"),
			conf_end_date: Date.parse("2015-6-9"),
			max_team_size: 6,
			min_team_size: 1,
			max_teams: 1,
			tamu_cost: 30.00,
			other_cost: 60.00,
			challenge_desc: 'yay!',
			)
			
		team = Team.create!(:conference => c1,	
			:school => "TestSchool",
			:paid_status => "paid", 
			:team_name => "team1" 
			)
			
		expect(Team.new(
			:conference => c1,	
			:school => "TestSchool",
			:paid_status => "paid",
			:team_name => "team2" 
		)).to_not be_valid
		
		team.destroy
		c1.destroy
	end
end
	
	describe "The model" do
    before(:all) do
      @inactive_conference = Conference.create!(start_date: Date.parse("2015-4-4"), 
        end_date: Date.parse("2015-6-6"),
        conf_start_date: Date.parse("2015-6-8"),
        conf_end_date: Date.parse("2015-6-9"),
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
            phone: "1876543211", phone_email: "1876543211@vtext.com",
            team: @active2, 
            account_attributes: {first_name: "A", last_name: "Z", email: "p1@example.com",
            password: "mypassword", password_confirmation: "mypassword"}
            )
           @not_captain1 = Participant.create!(captain: false, shirt_size: "M",
            phone: "1876543211", phone_email: "1876543211@vtext.com",
            team: @active2, 
            account_attributes: {first_name: "A", last_name: "Z", email: "p2@example.com",
            password: "mypassword", password_confirmation: "mypassword"}
            )
            @not_captain2 = Participant.create!(captain: false, shirt_size: "L",
            phone: "1876543211", phone_email: "1876543211@vtext.com",
            team: @active2, 
            account_attributes: {first_name: "A", last_name: "Z", email: "p3@example.com",
            password: "mypassword", password_confirmation: "mypassword"}
            )
            @not_captain3 = Participant.create!(captain: false, shirt_size: "L",
            phone: "1876543211", phone_email: "1876543211@vtext.com",
            team: @active2, 
            account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
            password: "mypassword", password_confirmation: "mypassword"}
            )
            @other_team_captain = Participant.create!(captain: true, shirt_size: "L",
            phone: "1876543211", phone_email: "1876543211@vtext.com",
            team: @active3, 
            account_attributes: {first_name: "A", last_name: "Z", email: "p5@example.com",
            password: "mypassword", password_confirmation: "mypassword"}
            )
            @other_team_not_captain = Participant.create!(captain: false, shirt_size: "S",
            phone: "1876543211", phone_email: "1876543211@vtext.com",
            team: @active3, 
            account_attributes: {first_name: "A", last_name: "Z", email: "p6@example.com",
            password: "mypassword", password_confirmation: "mypassword"}
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

        it "gets active teams" do
          expect(Team.get_active_teams()).to match_array([@active1, @active2, @active3])
        end
        
        it "gets participants from team" do
          expect(@active2.participants).to match_array([@captain, @not_captain1, @not_captain2, @not_captain3])
        end
        
        it "gets only captain from team" do
          expect(@active2.get_captain().size()).to eql(1)
          expect(@active2.get_captain()).to match([@captain])
        end
   end
end
  
