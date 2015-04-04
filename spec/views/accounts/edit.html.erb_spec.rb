require 'rails_helper'

RSpec.describe "accounts/edit", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :email => "MyString",
      :password_digest => "MyString",
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input#account_email[name=?]", "account[email]"

      assert_select "input#account_password_digest[name=?]", "account[password_digest]"

      assert_select "input#account_first_name[name=?]", "account[first_name]"

      assert_select "input#account_last_name[name=?]", "account[last_name]"
    end
  end
end
