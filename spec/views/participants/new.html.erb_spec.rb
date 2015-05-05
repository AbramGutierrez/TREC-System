require 'rails_helper'

RSpec.describe "participants/new", type: :view do
  before(:each) do
    assign(:participant, Participant.new(
      :captain => false,
      :waiver_signed => false,
      :shirt_size => "S",
	  :phone => "9876654321",
	  :account_attributes => {
	    email: "test@example.com",
		password: "password",
		first_name: "hello",
		last_name: "world"
	  }
    ))
	@admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"})
  end

  it "renders new participant form" do
    log_in_as(@admin.account)
    render

    assert_select "form[action=?][method=?]", participants_path, "post" do

      assert_select "input#participant_captain[name=?]", "participant[captain]"

      assert_select "input#participant_waiver_signed[name=?]", "participant[waiver_signed]"

      # assert_select "input#participant_shirt_size[name=?]", "participant[shirt_size]"
    end
  end
end
