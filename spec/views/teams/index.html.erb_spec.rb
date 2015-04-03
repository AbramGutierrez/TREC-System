require 'rails_helper'

RSpec.describe "teams/index", type: :view do
  before(:each) do
    assign(:teams, [
      Team.create!(
        :team_name => "Team Name",
        :paid_status => "Paid Status",
        :school => "School"
      ),
      Team.create!(
        :team_name => "Team Name",
        :paid_status => "Paid Status",
        :school => "School"
      )
    ])
  end

  it "renders a list of teams" do
    render
    assert_select "tr>td", :text => "Team Name".to_s, :count => 2
    assert_select "tr>td", :text => "Paid Status".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
  end
end
