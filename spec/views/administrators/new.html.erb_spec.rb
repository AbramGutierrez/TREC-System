require 'rails_helper'

RSpec.describe "administrators/new", type: :view do
  before(:each) do
    assign(:administrator, Administrator.new())
  end

  it "renders new administrator form" do
    render

    assert_select "form[action=?][method=?]", administrators_path, "post" do
    end
  end
end
