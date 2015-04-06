require 'rails_helper'

RSpec.describe "participants/show", type: :view do
  before(:each) do
    @participant = assign(:participant, Participant.create!(
      :captain => true,
      :waiver_signed => false,
      :shirt_size => "MyString",
	  :phone => 1111111111
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/true/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyString/)
	# expect(rendered).to match(/1111111111/)
  end
end
