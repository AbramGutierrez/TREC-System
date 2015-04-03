require 'rails_helper'

RSpec.describe "participants/show", type: :view do
  before(:each) do
    @participant = assign(:participant, Participant.create!(
      :captain => false,
      :waiver_signed => false,
      :shirt_size => "Shirt Size"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Shirt Size/)
  end
end
