require 'rails_helper'

RSpec.describe "Administrators", type: :request do
  before(:each) do
	    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "password", password_confirmation: "password"}) 
  end
	
  after(:each) do
	@admin.destroy
  end

  describe "GET /administrators" do
    it "works! (now write some real specs)" do
      log_in_as(@admin.account)
	  get administrators_path
      expect(response).to have_http_status(200)
    end
  end
end
