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
end