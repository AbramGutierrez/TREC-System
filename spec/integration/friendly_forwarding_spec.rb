require 'rails_helper'

RSpec.describe "friendly forwarding", :type => :request do
    before(:each) do
		@p = Participant.create!(captain: false, shirt_size: "medium", 
			phone: 1234567890)
		@p.create_account!(first_name: "TestFirst", last_name: "TestLast",
			email: "friendly_forward@example.com", password: "password",
			password_confirmation: "password")
	end
	
	after(:each) do
		@p.account.delete
	end
	
	it 'user is properly redirected with friendly forwarding' do
		get edit_account_path(@p.account)
	    expect(response).to redirect_to(login_path)
	    log_in_as(@p.account)
	    expect(response).to redirect_to(edit_account_path(@p.account))
	end
end