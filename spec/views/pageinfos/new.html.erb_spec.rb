require 'rails_helper'

RSpec.describe "pageinfos/new", type: :view do
  before(:each) do
    assign(:pageinfo, Pageinfo.new(
      :page => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new pageinfo form" do
    render

    assert_select "form[action=?][method=?]", pageinfos_path, "post" do

      assert_select "input#pageinfo_page[name=?]", "pageinfo[page]"

      assert_select "textarea#pageinfo_body[name=?]", "pageinfo[body]"
    end
  end
end
