require 'rails_helper'

RSpec.describe "conferences/show", type: :view do
  before(:each) do
    @conference = assign(:conference, Conference.create!(
      :start_date => Date.parse("2015-4-4"), 
	  :end_date => Date.parse("2015-6-6"),
	  :max_team_size => 1,
      :min_team_size => 2,
      :max_teams => 3,
      :tamu_cost => 1.5,
      :other_cost => 1.5,
      :challenge_desc => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/MyText/)
  end
end
