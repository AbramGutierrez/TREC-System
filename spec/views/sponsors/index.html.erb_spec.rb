require 'rails_helper'

RSpec.describe "sponsors/index", type: :view do
  before(:each) do
    assign(:sponsors, [
      Sponsor.create!(
        :sponsor_name => "Sponsor Name",
        :logo_path => "Logo Path",
        :priority => 1
      ),
      Sponsor.create!(
        :sponsor_name => "Sponsor Name",
        :logo_path => "Logo Path",
        :priority => 1
      )
    ])
  end

  it "renders a list of sponsors" do
    render
    assert_select "tr>td", :text => "Sponsor Name".to_s, :count => 2
    assert_select "tr>td", :text => "Logo Path".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
