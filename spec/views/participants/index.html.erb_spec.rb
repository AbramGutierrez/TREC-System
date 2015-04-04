require 'rails_helper'

RSpec.describe "participants/index", type: :view do
  before(:each) do
    assign(:participants, [
      Participant.create!(
        :captain => false,
        :waiver_signed => true,
        :shirt_size => "Shirt Size"
      ),
      Participant.create!(
        :captain => false,
        :waiver_signed => true,
        :shirt_size => "Shirt Size"
      )
    ])
  end

  it "renders a list of participants" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => true.to_s, :count => 2
    assert_select "tr>td", :text => "Shirt Size".to_s, :count => 2
  end
end
