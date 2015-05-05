require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      :rank => 1,
      :group => "MyString",
      :position => "MyString",
      :name => "MyString",
      :email => "MyString",
      :other => "MyString"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_rank[name=?]", "contact[rank]"

      assert_select "input#contact_group[name=?]", "contact[group]"

      assert_select "input#contact_position[name=?]", "contact[position]"

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_other[name=?]", "contact[other]"
    end
  end
end
