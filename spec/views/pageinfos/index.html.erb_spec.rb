require 'rails_helper'

RSpec.describe "pageinfos/index", type: :view do
  before(:each) do
    assign(:pageinfos, [
      Pageinfo.create!(
        :page => "Page",
        :body => "MyText"
      ),
      Pageinfo.create!(
        :page => "Page",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of pageinfos" do
    render
    assert_select "tr>td", :text => "Page".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
