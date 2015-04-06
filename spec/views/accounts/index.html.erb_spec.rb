require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    p1 = Participant.create(captain: false, shirt_size: "medium", 
			phone: 1234567890)
	p2 = Participant.create(captain: false, shirt_size: "medium", 
			phone: 1234567899)		
    assign(:accounts, [
      Account.create!(
        :email => "test_email@example.com",
		:password => "password",
		:password_confirmation => "password",
		:first_name => "TestFirstName",
		:last_name => "TestLastName",
		:user => p1
      ),
      Account.create!(
        :email => "test_email2@example.com",
		:password => "password",
		:password_confirmation => "password",
		:first_name => "TestFirstName",
		:last_name => "TestLastName",
		:user => p2
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => "test_email@example.com".to_s, :count => 1
	assert_select "tr>td", :text => "test_email2@example.com".to_s, :count => 1
	# The password is stored encrypted so I'm not sure how to test this part
    # assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
    assert_select "tr>td", :text => "TestFirstName".to_s, :count => 2
    assert_select "tr>td", :text => "TestLastName".to_s, :count => 2
  end
end
