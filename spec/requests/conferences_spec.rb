require 'rails_helper'

RSpec.describe "Conferences", type: :request do
  before(:each) do
		@admin = Administrator.create!()
		@admin.create_account!(first_name: "TestFirst", last_name: "TestLast",
			email: "tester@example.com", password: "password",
			password_confirmation: "password")
  end
	
  after(:each) do
	@admin.account.delete
  end

  describe "GET /conferences" do
    it "works! (now write some real specs)" do
	  log_in_as(@admin.account)
      get conferences_path
      expect(response).to have_http_status(200)
    end
  end
end
