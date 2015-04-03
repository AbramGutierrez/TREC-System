require 'rails_helper'

RSpec.describe "teams/show", type: :view do
  before(:each) do
    @team = assign(:team, Team.create!(
      :team_name => "Team Name",
      :paid_status => "Paid Status",
      :school => "School"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Team Name/)
    expect(rendered).to match(/Paid Status/)
    expect(rendered).to match(/School/)
  end
end
