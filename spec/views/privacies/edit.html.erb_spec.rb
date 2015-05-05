require 'rails_helper'

RSpec.describe "privacies/edit", type: :view do
  before(:each) do
    @privacy = assign(:privacy, Privacy.create!(
      :order => 1,
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit privacy form" do
    render

    assert_select "form[action=?][method=?]", privacy_path(@privacy), "post" do

      assert_select "input#privacy_order[name=?]", "privacy[order]"

      assert_select "input#privacy_title[name=?]", "privacy[title]"

      assert_select "textarea#privacy_body[name=?]", "privacy[body]"
    end
  end
end
