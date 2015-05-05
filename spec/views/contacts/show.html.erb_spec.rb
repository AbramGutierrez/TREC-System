require 'rails_helper'

RSpec.describe "contacts/show", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :rank => 1,
      :group => "Group",
      :position => "Position",
      :name => "Name",
      :email => "Email",
      :other => "Other"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Group/)
    expect(rendered).to match(/Position/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Other/)
  end
end
