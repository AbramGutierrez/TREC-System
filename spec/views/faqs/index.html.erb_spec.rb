require 'rails_helper'

RSpec.describe "faqs/index", type: :view do
  before(:each) do
    assign(:faqs, [
      Faq.create!(
        :order => 1,
        :question => "MyText",
        :answer => "MyText2"
      ),
      Faq.create!(
        :order => 1,
        :question => "MyText",
        :answer => "MyText2"
      )
    ])
	@admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"})
  end

  it "renders a list of faqs" do
    log_in_as(@admin.account)
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText2".to_s, :count => 2
  end
end
