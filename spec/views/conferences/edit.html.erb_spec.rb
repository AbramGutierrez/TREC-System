require 'rails_helper'

RSpec.describe "conferences/edit", type: :view do
  before(:each) do
    @conference = assign(:conference, Conference.create!(
      :start_date => Date.parse("2015-4-4"), 
	  :end_date => Date.parse("2015-6-6"),
	  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
	  :max_team_size => 1,
      :min_team_size => 1,
      :max_teams => 1,
      :tamu_cost => 1.5,
      :other_cost => 1.5,
      :challenge_desc => "MyText"
    ))
  end

  it "renders the edit conference form" do
    render

    assert_select "form[action=?][method=?]", conference_path(@conference), "post" do

      assert_select "input#conference_max_team_size[name=?]", "conference[max_team_size]"

      assert_select "input#conference_min_team_size[name=?]", "conference[min_team_size]"

      assert_select "input#conference_max_teams[name=?]", "conference[max_teams]"

      assert_select "input#conference_tamu_cost[name=?]", "conference[tamu_cost]"

      assert_select "input#conference_other_cost[name=?]", "conference[other_cost]"

      assert_select "textarea#conference_challenge_desc[name=?]", "conference[challenge_desc]"
    end
  end
end
