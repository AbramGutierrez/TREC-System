require 'rails_helper'

RSpec.describe "terms/index", type: :view do
  before(:each) do
    assign(:terms, [
      Term.create!(
        :order => 1,
        :title => "Title",
        :body => "MyText"
      ),
      Term.create!(
        :order => 1,
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of terms" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
