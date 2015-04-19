require 'rails_helper'

RSpec.describe "administrators/show", type: :view do
  before(:each) do
    @administrator = assign(:administrator, Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"}))
  end

  it "renders attributes in <p>" do
    render
  end
end
