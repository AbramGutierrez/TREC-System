require 'rails_helper'

RSpec.describe "accounts/show", type: :view do
  before(:each) do
    p = Participant.create(captain: false, shirt_size: "medium", 
			phone: "1234567890")
    @account = assign(:account, Account.create!(
      :email => "test_email@example.com",
      :password => "password",
	  :password_confirmation => "password",
      :first_name => "TestFirstName",
      :last_name => "TestLastName",
	  :user => p
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
	# Password is stored encrypted so it won't match.
    expect(rendered).not_to match(/Password Digest/)
    expect(rendered).to match(/TestFirstName/)
    expect(rendered).to match(/TestLastName/)
  end
end
