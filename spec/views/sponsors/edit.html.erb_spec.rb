require 'rails_helper'

RSpec.describe "sponsors/edit", type: :view do
  before(:each) do
    @sponsor = assign(:sponsor, Sponsor.create!(
      :sponsor_name => "MyString",
      :logo_path => "MyString",
      :priority => 1
    ))
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
