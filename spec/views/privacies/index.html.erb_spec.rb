require 'rails_helper'

RSpec.describe "privacies/index", type: :view do
  before(:each) do
    assign(:privacies, [
      Privacy.create!(
        :order => 1,
        :title => "Title",
        :body => "MyText"
      ),
      Privacy.create!(
        :order => 2,
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of privacies" do
    render
	# Order is not shown on the view
    # assert_select "tr>td", :text => 1.to_s, :count => 2
    # assert_select "tr>td", :text => "Title".to_s, :count => 2
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
