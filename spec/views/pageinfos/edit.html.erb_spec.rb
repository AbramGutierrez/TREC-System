require 'rails_helper'

RSpec.describe "pageinfos/edit", type: :view do
  before(:each) do
    @pageinfo = assign(:pageinfo, Pageinfo.create!(
      :page => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit pageinfo form" do
    render

    assert_select "form[action=?][method=?]", pageinfo_path(@pageinfo), "post" do

      assert_select "input#pageinfo_page[name=?]", "pageinfo[page]"

      assert_select "textarea#pageinfo_body[name=?]", "pageinfo[body]"
    end
  end
end
