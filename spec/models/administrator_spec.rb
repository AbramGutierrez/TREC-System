require 'rails_helper'

RSpec.describe Administrator, type: :model do
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
