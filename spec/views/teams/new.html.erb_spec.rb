require 'rails_helper'

RSpec.describe "teams/new", type: :view do
  before(:each) do
    assign(:team, Team.new(
      :team_name => "MyString",
      :paid_status => "MyString",
      :school => "MyString"
    ))
	
	@admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "password", password_confirmation: "password"}) 
  end
  
  after(:all) do
		first = Conference.first
		first.is_active = true
		first.save!
  end

  it "renders new team form" do
	log_in_as(@admin.account)
    render

    assert_select "form[action=?][method=?]", teams_path, "post" do

      assert_select "input#team_team_name[name=?]", "team[team_name]"

      # assert_select "input#team_paid_status[name=?]", "team[paid_status]"

	  # Need to test with cucumber
      # assert_select "input#team_school[name=?]", "team[school]"
    end
  end
end
