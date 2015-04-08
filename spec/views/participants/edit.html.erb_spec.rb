require 'rails_helper'

RSpec.describe "participants/edit", type: :view do
  before(:each) do
    @participant = assign(:participant, Participant.create!(
      :captain => true,
      :waiver_signed => false,
      :shirt_size => "MyString",
	  :phone => 1111111111
    ))
  end

  it "renders the edit participant form" do
    render

    assert_select "form[action=?][method=?]", participant_path(@participant), "post" do

      assert_select "input#participant_captain[name=?]", "participant[captain]"

      assert_select "input#participant_waiver_signed[name=?]", "participant[waiver_signed]"

      assert_select "input#participant_shirt_size[name=?]", "participant[shirt_size]"
    end
  end
end