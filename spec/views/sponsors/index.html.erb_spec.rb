require 'rails_helper'

RSpec.describe "sponsors/index", type: :view do
  before(:all) do
	@c = Conference.create!(start_date: Date.parse("2015-4-10"), 
	  end_date: Date.parse("2015-6-12"),
	  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
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
    assign(:sponsors, [
      Sponsor.create!(
	    :conference => @c,
        :sponsor_name => "Sponsor Name",
        :logo_path => file,
        :priority => 1
      ),
      Sponsor.create!(
	    :conference => @c,
        :sponsor_name => "Sponsor Name",
        :logo_path => file,
        :priority => 1
      )
    ])
	@conference_array = Array.new
	@conference_array.push(@c)
  end

  it "renders a list of sponsors" do
    render
    assert_select "tr>td", :text => "Sponsor Name".to_s, :count => 2
    # assert_select "tr>td", :text => "Logo Path".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
