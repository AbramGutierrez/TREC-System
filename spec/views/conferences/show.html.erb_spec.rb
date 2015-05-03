require 'rails_helper'

RSpec.describe "conferences/show", type: :view do
  before(:each) do
    @conference = assign(:conference, Conference.create!(
      :start_date => Date.parse("2015-4-4"), 
	  :end_date => Date.parse("2015-6-6"),
	  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
	  :max_team_size => 2,
      :min_team_size => 1,
      :max_teams => 3,
      :tamu_cost => 1.5,
      :other_cost => 1.5,
      :challenge_desc => "MyText"
    ))
	@admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"})
  end

  it "renders attributes in <p>" do
    log_in_as(@admin.account)
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/MyText/)
  end
end
