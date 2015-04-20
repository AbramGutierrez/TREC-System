require 'rails_helper'

RSpec.describe "sponsors/new", type: :view do
  before(:each) do
    image = "/tamu.png"
    file = fixture_file_upload(image, "image/png")
    @sponsor = assign(:sponsor, Sponsor.create!(
	  :conference => Conference.first,
      :sponsor_name => "MyString",
      :logo_path => file,
      :priority => 1
    ))
	@conference_array = Array.new
	@conference_array.push(Conference.first)
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
