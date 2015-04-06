require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    p = Participant.create(captain: false, shirt_size: "medium", 
			phone: 1234567890)
    @account = assign(:account, Account.create!(
      :email => "test_email@example.com",
      :password => "password",
	  # :password_confirmation => "password",
      :first_name => "TestFirstName",
      :last_name => "TestLastName",
	  :user => p
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input#account_email[name=?]", "account[email]"
	  
	  # The password probably needs to be tested with a different test
      # assert_select "input#account_password_digest[name=?]", "account[password_digest]"

      assert_select "input#account_first_name[name=?]", "account[first_name]"

      assert_select "input#account_last_name[name=?]", "account[last_name]"
    end
  end
end
