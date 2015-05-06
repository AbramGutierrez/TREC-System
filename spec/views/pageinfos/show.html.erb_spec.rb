require 'rails_helper'

RSpec.describe "pageinfos/show", type: :view do
  before(:each) do
    @pageinfo = assign(:pageinfo, Pageinfo.create!(
      :page => "Page",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Page/)
    expect(rendered).to match(/MyText/)
  end
end
