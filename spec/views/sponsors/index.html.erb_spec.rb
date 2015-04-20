require 'rails_helper'

RSpec.describe "sponsors/index", type: :view do
  before(:each) do
    image = "/tamu.png"
    file = fixture_file_upload(image, "image/png")
    assign(:sponsors, [
      Sponsor.create!(
	    :conference => Conference.first,
        :sponsor_name => "Sponsor Name",
        :logo_path => file,
        :priority => 1
      ),
      Sponsor.create!(
	    :conference => Conference.first,
        :sponsor_name => "Sponsor Name",
        :logo_path => file,
        :priority => 1
      )
    ])
	@conference_array = Array.new
	@conference_array.push(Conference.first)
  end

  it "renders a list of sponsors" do
    render
    assert_select "tr>td", :text => "Sponsor Name".to_s, :count => 2
    # assert_select "tr>td", :text => "Logo Path".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
