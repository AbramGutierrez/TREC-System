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
  
  describe "when going to #create" do
    it "redirects to root url when not logged in" do
      get :create, valid_session
      expect(flash.now).to be_present
      expect(response).to redirect_to(login_url)
    end
    
    it "redirects to root url with logged in as participant" do
      log_in_as(@captain.account)
      get :create, valid_session
      expect(flash.now).to be_present
      expect(response).to redirect_to(root_url)
    end
  end
  
  describe "when going to #new" do
    it "redirects to root url when not logged in" do
      get :new, valid_session
      expect(flash.now).to be_present
      expect(response).to redirect_to(login_url)
    end
    
    it "redirects to root url with logged in as participant" do
      log_in_as(@captain.account)
      get :new, valid_session
      expect(flash.now).to be_present
      expect(response).to redirect_to(root_url)
    end
    
    describe "when admin is logged in" do
      let(:valid_email) {{
        :recipients => Administrator.recipient_captain,
        :method => Administrator.method_email,
        :title_box => { :message_title => "A Valid Title" },
        :message_box => { :message_body => "Any length message is a valid message!" }
      }}
      
      it "shows the email page" do
        log_in_as(@admin.account)
        get :new, valid_session
        expect(response).to_not redirect_to(root_url)
      end
=begin      
      it "shows success page for valid input" do
        log_in_as(@admin.account)
        get :new, valid_session
        count = ActionMailer::Base.deliveries.count
        post :create, { :params => valid_email }, valid_session
        expect(ActionMailer::Base.deliveries.count).to eql(count + 1)
      end
=end
    end
  end
end
