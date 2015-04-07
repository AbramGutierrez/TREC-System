require 'rails_helper'

RSpec.describe "conferences/index", type: :view do
  before(:each) do
    assign(:conferences, [
      Conference.create!(
        :start_date => Date.parse("2015-4-4"), 
	    :end_date => Date.parse("2015-6-6"),
		:max_team_size => 1,
        :min_team_size => 2,
        :max_teams => 3,
        :tamu_cost => 1.5,
        :other_cost => 2.5,
        :challenge_desc => "MyText"
      ),
      Conference.create!(
	    :start_date => Date.parse("2015-4-4"), 
	    :end_date => Date.parse("2015-6-6"),
        :max_team_size => 1,
        :min_team_size => 2,
        :max_teams => 3,
        :tamu_cost => 1.5,
        :other_cost => 2.5,
        :challenge_desc => "MyText"
      )
    ])
  end

  it "renders a list of conferences" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
