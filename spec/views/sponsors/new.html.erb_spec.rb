require 'rails_helper'

RSpec.describe "sponsors/new", type: :view do
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
	first = Conference.first
		first.is_active = true
		first.save!
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

  it "renders new sponsor form" do
    render
	
	# Better to test with Cucumber
	
    # assert_select "form[action=?][method=?]", sponsors_path, "post" do

      # assert_select "input#sponsor_sponsor_name[name=?]", "sponsor[sponsor_name]"

      # assert_select "input#sponsor_logo_path[name=?]", "sponsor[logo_path]"

      # assert_select "input#sponsor_priority[name=?]", "sponsor[priority]"
    # end
  end
end
