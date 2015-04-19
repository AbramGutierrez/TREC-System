require 'rails_helper'

RSpec.describe "administrators/edit", type: :view do
  before(:each) do
    @administrator = assign(:administrator, Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"}))
  end

  it "renders the edit administrator form" do
    render

    assert_select "form[action=?][method=?]", administrator_path(@administrator), "post" do
    end
  end
end
