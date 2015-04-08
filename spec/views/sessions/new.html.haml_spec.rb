require 'rails_helper'

RSpec.describe "sessions/new.html.haml", type: :view do
  before(:each) do
    email = "test@example.com"
	password = "password"
  end
  
  it "renders log-in page" do
    render
	
	assert_select "form[action=?][method=?]", sessions_path, "post" do
	  assert_select "input#session_email[name=?]", "session[email]"
	  assert_select "input#session_password[name=?]", "session[password]"
	end
  end
end
