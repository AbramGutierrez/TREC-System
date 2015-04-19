require 'rails_helper'

RSpec.describe "administrators/index", type: :view do
  before(:each) do
    assign(:administrators, [
      Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"}),
      Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator2", email: "admin2@example.com",
			password: "admin", password_confirmation: "admin"})
    ])
  end

  it "renders a list of administrators" do
    render
  end
end
