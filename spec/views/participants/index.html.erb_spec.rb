require 'rails_helper'

RSpec.describe "participants/index", type: :view do
  before(:each) do
    assign(:participants, [
      Participant.create!(
        :captain => true,
        :waiver_signed => true,
        :shirt_size => "Shirt Size",
		:phone => "1111111111",
	    :account_attributes => {
	      email: "test@example.com",
		  password: "password",
		  first_name: "hello",
		  last_name: "world"
	  }
      ),
      Participant.create!(
        :captain => true,
        :waiver_signed => true,
        :shirt_size => "Shirt Size",
		:phone => "1111111111",
	    :account_attributes => {
	      email: "test2@example.com",
		  password: "password",
		  first_name: "hello",
		  last_name: "world"
	  }
      )
    ])
  end

  it "renders a list of participants" do
    #render
    # assert_select "tr>td", :text => false.to_s, :count => 2
    #assert_select "tr>td", :text => true.to_s, :count => 4 # 2
    #assert_select "tr>td", :text => "Shirt Size".to_s, :count => 2
  end
end
