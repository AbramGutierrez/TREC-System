require 'rails_helper'

RSpec.describe "contacts/edit", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :rank => 1,
      :group => "MyString",
      :position => "MyString",
      :name => "MyString",
      :email => "MyString",
      :other => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do

      assert_select "input#contact_rank[name=?]", "contact[rank]"

      assert_select "input#contact_group[name=?]", "contact[group]"

      assert_select "input#contact_position[name=?]", "contact[position]"

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_other[name=?]", "contact[other]"
    end
  end
end
