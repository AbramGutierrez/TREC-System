require 'rails_helper'

RSpec.describe "privacies/new", type: :view do
  before(:each) do
    assign(:privacy, Privacy.new(
      :order => 1,
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new privacy form" do
    render

    assert_select "form[action=?][method=?]", privacies_path, "post" do

      assert_select "input#privacy_order[name=?]", "privacy[order]"

      assert_select "input#privacy_title[name=?]", "privacy[title]"

      assert_select "textarea#privacy_body[name=?]", "privacy[body]"
    end
  end
end
