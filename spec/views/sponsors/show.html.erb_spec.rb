require 'rails_helper'

RSpec.describe "sponsors/show", type: :view do
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sponsor Name/)
    # expect(rendered).to match(/Logo Path/)
    expect(rendered).to match(/1/)
  end
end
