require 'rails_helper'

RSpec.describe "sponsors/show", type: :view do
  before(:each) do
    @sponsor = assign(:sponsor, Sponsor.create!(
      :sponsor_name => "Sponsor Name",
      :logo_path => "Logo Path",
      :priority => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sponsor Name/)
    expect(rendered).to match(/Logo Path/)
    expect(rendered).to match(/1/)
  end
end
