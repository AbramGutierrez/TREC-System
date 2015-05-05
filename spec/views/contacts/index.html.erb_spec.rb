require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :rank => 1,
        :group => "Group",
        :position => "Position",
        :name => "Name",
        :email => "Email",
        :other => "Other"
      ),
      Contact.create!(
        :rank => 1,
        :group => "Group",
        :position => "Position",
        :name => "Name",
        :email => "Email",
        :other => "Other"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Group".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Other".to_s, :count => 2
  end
end
