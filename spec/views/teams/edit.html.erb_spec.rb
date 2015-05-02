require 'rails_helper'

RSpec.describe "teams/edit", type: :view do
  before(:each) do
    c = Conference.create(start_date: Date.parse("2015-4-4"), 
	  end_date: Date.parse("2015-6-6"),
	  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 5,
	  tamu_cost: 30.00,
	  other_cost: 60.00,
	  challenge_desc: 'yay!',
	  created_at: DateTime.parse("2015-4-3"),
	  updated_at: DateTime.parse("2015-4-3"),
	  is_active: true
	  )
    @team = assign(:team, Team.create!(
      :team_name => "MyString",
      :paid_status => "MyString",
      :school => "MyString",
	  :conference => c
    ))
  end

  it "renders the edit team form" do
    render

    assert_select "form[action=?][method=?]", team_path(@team), "post" do

      assert_select "input#team_team_name[name=?]", "team[team_name]"

      assert_select "input#team_paid_status[name=?]", "team[paid_status]"

      assert_select "input#team_school[name=?]", "team[school]"
    end
  end
end
