require 'rails_helper'

RSpec.describe "administrators/index", type: :view do
  before(:each) do
    assign(:administrators, [
      Administrator.create!(),
      Administrator.create!()
    ])
  end

  it "renders a list of administrators" do
    render
  end
end
