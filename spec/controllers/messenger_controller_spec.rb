require 'rails_helper'

RSpec.describe MessengerController, type: :controller do
  before(:all) do
         @active_conference = Conference.create!(start_date: Date.parse("2015-4-4"), 
          end_date: Date.parse("2015-6-6"),
          conf_start_date: Date.parse("2015-6-8"),
          conf_end_date: Date.parse("2015-6-9"),
          max_team_size: 6,
          min_team_size: 1,
          max_teams: 5,
          tamu_cost: 30.00,
          other_cost: 60.00,
          challenge_desc: 'yay!',
          is_active: true
          )
           @active2 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team5" 
            )
            @admin = Administrator.new(account_attributes: {first_name: "first", last_name: "last",
                  email: "valid_email@test.com", password: "123456",
                  password_confirmation: "123456"})
            @captain = Participant.create!(captain: true, shirt_size: "S",
              phone: "1876543211", team: @active2, phone_email: "1876543211@place.com", 
              account: Account.create!(first_name: "A", last_name: "Z", email: "p1@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
        end
      
  after(:all) do
        @active_conference.destroy
        @active2.destroy
        @captain.destroy
  end
  
  let(:valid_session) {{}}
  
  it "redirects to root url when not logged in" do
    get :new, valid_session
    expect(flash).to_not be_nil
    expect(response).to redirect_to(login_url)
  end
  
  it "redirects to root url with logged in as participant" do
    log_in_as(@captain.account)
    get :new, valid_session
    expect(flash).to_not be_nil
    expect(response).to redirect_to(root_url)
  end
  
  describe "when admin is logged in" do
    it "shows the email page" do
      log_in_as(@captain.account)
    get :new, valid_session
    expect(flash).to be_nil
    expect(response).to redirect_to(root_url)
    end
  end
end
