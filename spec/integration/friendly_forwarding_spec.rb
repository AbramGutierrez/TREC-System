require 'rails_helper'

RSpec.describe "friendly forwarding", :type => :request do
    before(:each) do
		@p = Participant.create!(captain: false, shirt_size: "large",
			phone: "1876543211", account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "password", password_confirmation: "password"})
	end
	
	after(:each) do
		@p.destroy
	end
	
	it 'user is properly redirected with friendly forwarding' do

		get edit_account_path(@p.account)
	    expect(response).to redirect_to(login_path)
	    log_in_as(@p.account)
	    expect(response).to redirect_to(edit_account_path(@p.account))
	end
end