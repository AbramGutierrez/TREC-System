require 'rails_helper'

RSpec.describe Account, type: :model do
    before(:each) do
		@account = Account.new(first_name: "first", last_name: "last",
								email: "valid_email@test.com", password: "123456",
								password_confirmation: "123456")
		@admin = Administrator.create!(account_attributes: {first_name: "first", last_name: "last",
								email: "admin@test.com", password: "123456",
								password_confirmation: "123456"})						
    end
	
	it "should be valid" do
		expect(@account).to be_valid
	end
	
	it "should require an email" do
		expect(Account.new(first_name: "first", last_name: "last",
								email: "", password: "123456",
								password_confirmation: "123456")).to_not be_valid
	end
	
	it "should require a valid email" do
		expect(Account.new(first_name: "first", last_name: "last",
								email: "invalid_email", password: "123456",
								password_confirmation: "123456")).to_not be_valid
	end
	
	it "should not allow an email longer than the max length" do
		invalid_email = "a" * 244 + "@example.com"
		expect(Account.new(first_name: "first", last_name: "last",
			:email => invalid_email, password: "123456",
								password_confirmation: "123456")).to_not be_valid
	end
	
	it "should not allow duplicate email addresses" do
		# duplicate_email = @account.dup
		# @account.save
		# expect(duplicate_email).to_not be_valid
		
		duplicate = @admin.account.dup
		expect(duplicate).to_not be_valid
	end
	
	it "should ignore case when saving email" do
		duplicate = @admin.account.dup
		duplicate.email = @admin.account.email.upcase
		# @account.save
		expect(duplicate).to_not be_valid
	end
	
	it "should combine first and last name" do
	  expect(@account.name).to eq(@account.first_name.to_s + " " + @account.last_name.to_s)
	end
	
	# it "should enforce a minimum password length" do
		# @account.password = @account.password_confirmation = "a" * 5
		# @account.should_not be_valid
	# end
end

RSpec.describe Account, type: :model do
  it "should accept only a first name" do
    account = Account.new(first_name: "first",
                email: "valid_email@test.com", password: "123456",
                password_confirmation: "123456", user: p)
    expect(account.name).to eq(account.first_name.to_s)
  end
  
  it "should accept only a last name" do
    account = Account.new(last_name: "last",
                email: "valid_email@test.com", password: "123456",
                password_confirmation: "123456", user: p)
    expect(account.name).to eq(account.last_name.to_s)
  end
  
  it "should have a first or last name" do
    expect(account = Account.new(:first_name => "", :last_name => "",
		:email => "avalidemail@valid.com", :password => "123456",
		:password_confirmation => "123456")).to_not be_valid
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
      
      it "should get all active accounts" do
        expect(Account.get_active).to match_array([@captain.account, @not_captain1.account, @not_captain2.account, @not_captain3.account])
      end
  end
end