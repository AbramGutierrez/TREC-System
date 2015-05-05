require 'rails_helper'

RSpec.describe "privacies/show", type: :view do
  before(:each) do
    @privacy = assign(:privacy, Privacy.create!(
      :order => 1,
      :title => "Title",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
