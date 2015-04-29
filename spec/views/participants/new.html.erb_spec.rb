require 'rails_helper'

RSpec.describe "participants/new", type: :view do
  before(:each) do
    assign(:participant, Participant.new(
      :captain => false,
      :waiver_signed => false,
      :shirt_size => "Small",
	  :phone => "9876654321",
	  :account_attributes => {
	    email: "test@example.com",
		password: "password",
		first_name: "hello",
		last_name: "world"
	  }
    ))
  end

  it "renders new participant form" do
    render

    assert_select "form[action=?][method=?]", participants_path, "post" do

      assert_select "input#participant_captain[name=?]", "participant[captain]"

      assert_select "input#participant_waiver_signed[name=?]", "participant[waiver_signed]"

      # assert_select "input#participant_shirt_size[name=?]", "participant[shirt_size]"
    end
  end
end
