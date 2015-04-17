require 'rails_helper'

RSpec.describe "participants/show", type: :view do
  before(:each) do
    @new_team = Team.create!(:conference_id => 1,	
	  :school => "TestSchool",
	  :paid_status => "paid", 
	  :team_name => "ParticipantShowTeam" 
	  )
    @participant = assign(:participant, Participant.create!(
	  :team_id => @new_team.id,
      :captain => true,
      :waiver_signed => false,
      :shirt_size => "MyString",
	  :phone => 1111111111
    ))
	@account = Account.create!(
		email: "test@example.com",
		password: "password",
		first_name: "hello",
		last_name: "world",
		user: @participant

	)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/true/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyString/)
	# expect(rendered).to match(/1111111111/)
  end
end
