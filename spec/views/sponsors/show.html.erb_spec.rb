require 'rails_helper'

RSpec.describe "sponsors/show", type: :view do
  before(:all) do
	@c = Conference.create!(start_date: Date.parse("2015-4-10"), 
	  end_date: Date.parse("2015-6-12"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 6,
	  tamu_cost: 20.00,
	  other_cost: 40.00,
	  challenge_desc: 'fun!',
	  is_active: true
	  )
  end
  after(:all) do
	@c.destroy
  end
  
  before(:each) do
    image = "/tamu.png"
    file = fixture_file_upload(image, "image/png")
    @sponsor = assign(:sponsor, Sponsor.create!(
	  :conference => @c,
      :sponsor_name => "MyString",
      :logo_path => file,
      :priority => 1
    ))
	@conference_array = Array.new
	@conference_array.push(@c)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sponsor Name/)
    # expect(rendered).to match(/Logo Path/)
    expect(rendered).to match(/1/)
  end
end
