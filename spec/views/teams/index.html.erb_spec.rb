require 'rails_helper'

RSpec.describe "teams/index", type: :view do
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
    assign(:teams, [
      Team.create!(
        :team_name => "Team1",
        :paid_status => "Paid Status",
        :school => "School",
		:conference => c
      ),
      Team.create!(
        :team_name => "Team2",
        :paid_status => "Paid Status",
        :school => "School",
		:conference => c
      )
    ])
  end

  it "renders a list of teams" do
    render
    assert_select "tr>td", :text => "Team1".to_s, :count => 1
	assert_select "tr>td", :text => "Team2".to_s, :count => 1
    assert_select "tr>td", :text => "Paid Status".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
  end
end
