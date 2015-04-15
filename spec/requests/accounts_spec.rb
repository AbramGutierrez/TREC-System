require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  before(:each) do
		@p = Participant.create!(captain: false, shirt_size: "medium", 
			phone: 1234567890)
		@p.create_account!(first_name: "TestFirst", last_name: "TestLast",
			email: "tester@example.com", password: "password",
			password_confirmation: "password")
  end
	
  after(:each) do
	@p.account.delete
  end

  describe "GET /accounts" do
    it "works! (now write some real specs)" do
	  log_in_as(@p.account)
      get accounts_path
      expect(response).to have_http_status(200)
    end
  end
end
