require 'rails_helper'

RSpec.describe "sponsors/edit", type: :view do
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

  it "renders the edit sponsor form" do
    render

    assert_select "form[action=?][method=?]", sponsor_path(@sponsor), "post" do

      assert_select "input#sponsor_sponsor_name[name=?]", "sponsor[sponsor_name]"

      assert_select "input#sponsor_logo_path[name=?]", "sponsor[logo_path]"

      assert_select "input#sponsor_priority[name=?]", "sponsor[priority]"
    end
  end
end
