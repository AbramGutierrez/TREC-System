require 'rails_helper'

RSpec.describe Account, type: :model do
    before(:each) do
		@account = Account.new
		@account.first_name = "first"
		@account.last_name = "last"
		@account.email = "valid_email@test.com"
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
end
