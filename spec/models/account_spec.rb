require 'rails_helper'

RSpec.describe Account, type: :model do
    before(:each) do
		p = Participant.create(captain: false, shirt_size: "medium", 
			phone: "1234567890")
		@account = Account.new(first_name: "first", last_name: "last",
								email: "valid_email@test.com", password: "123456",
								password_confirmation: "123456", user: p)
    end
	
	it "should be valid" do
		@account.should be_valid
	end
	
	it "should require an email" do
		Account.new(:email => "").should_not be_valid
	end
	
	it "should require a valid email" do
		Account.new(:email => "invalid_email").should_not be_valid
	end
	
	it "should not allow an email longer than the max length" do
		invalid_email = "a" * 244 + "@example.com"
		Account.new(:email => invalid_email).should_not be_valid
	end
	
	it "should not allow duplicate email addresses" do
		duplicate_email = @account.dup
		@account.save
		duplicate_email.should_not be_valid
	end
	
	it "should ignore case when saving email" do
		duplicate_email = @account.dup
		duplicate_email.email = @account.email.upcase
		@account.save
		duplicate_email.should_not be_valid
	end
	
	it "should combine first and last name" do
	  @account.name.should eql(@account.first_name.to_s + " " + @account.last_name.to_s)
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
    account.name.should eql(account.first_name.to_s)
  end
  
  it "should accept only a last name" do
    account = Account.new(last_name: "last",
                email: "valid_email@test.com", password: "123456",
                password_confirmation: "123456", user: p)
    account.name.should eql(account.last_name.to_s)
  end
  
  it "should have a first or last name" do
    account = Account.new(:first_name => "", :last_name => "").should_not be_valid
  end
end