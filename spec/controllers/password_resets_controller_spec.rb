require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  before(:all) do
        @inactive_conference = Conference.create!(start_date: Date.parse("2015-4-4"), 
          end_date: Date.parse("2015-6-6"),
          conf_start_date: Date.parse("2015-1-1"),
          conf_end_date: Date.parse("2015-2-2"),
          max_team_size: 6,
          min_team_size: 1,
          max_teams: 5,
          tamu_cost: 30.00,
          other_cost: 60.00,
          challenge_desc: 'yay!',
          is_active: false
         )
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
          
          @inactive_team1 = Team.create!(:conference => @inactive_conference, 
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team1" 
            )
           @inactive_team2 = Team.create!(:conference => @inactive_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team2" 
            )
            @inactive_team3 = Team.create!(:conference => @inactive_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team3" 
            )
           @active1 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team4" 
            )
           @active2 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team5" 
            )
           @active3 = Team.create!(:conference => @active_conference,  
            :school => "TestSchool",
            :paid_status => "paid", 
            :team_name => "team6" 
            )
            @captain = Participant.create!(captain: true, shirt_size: "S",
              phone: "1876543211", team: @active2, phone_email: "1876543211@place.com", 
              account: Account.create!(first_name: "A", last_name: "Z", email: "p1@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
             @not_captain1 = Participant.create!(captain: false, shirt_size: "XL",
              phone: "3009098512", team: @active2, phone_email: "3009098512@place.com", 
              account: Account.create!(first_name: "A", last_name: "Z", email: "p2@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @not_captain2 = Participant.create!(captain: false, shirt_size: "XL",
              phone: "8133614073", team: @active2, phone_email: "8133614073@place.com", 
              account: Account.create!(first_name: "A", last_name: "Z", email: "p3@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @not_captain3 = Participant.create!(captain: false, shirt_size: "M",
              phone: "9642752086", team: @active2, phone_email: "9642752086@att.com", 
              account: Account.create!(first_name: "A", last_name: "Z", email: "p4@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @other_team_captain = Participant.create!(captain: true, shirt_size: "M",
              phone: "4296814083", team: @active3, phone_email: "4296814083@att.com", 
              account: Account.create!(first_name: "A", last_name: "Z", email: "p5@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
              @other_team_not_captain = Participant.create!(captain: false, shirt_size: "S",
              phone: "7282822361", team: @active3, phone_email: "7282822361@great.yeah",
              account: Account.create!(first_name: "A", last_name: "Z", email: "p6@example.com",
              password: "mypassword", password_confirmation: "mypassword")
              )
        end
      
  after(:all) do
        @inactive_conference.destroy
        @active_conference.destroy
        @inactive_team1.destroy
        @inactive_team2.destroy
        @inactive_team3.destroy
        @active1.destroy
        @active2.destroy
        @active3.destroy
        @captain.destroy
        @not_captain1.destroy
        @not_captain2.destroy
        @not_captain3.destroy
        @other_team_captain.destroy
        @other_team_not_captain.destroy
  end
  
  let(:valid_email) {
    { :email => "p1@example.com" }
  }
  
  let(:invalid_email) {
    { :email => "LOL@no.com" }
  }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "sends an email" do
      first_count = ActionMailer::Base.deliveries.count
      post :create, { :password_reset => valid_email }
      expect(ActionMailer::Base.deliveries.count).to eql(first_count + 1)
    end

    it "redirects to home" do
      post :create, { :password_reset => valid_email }
      expect(response).to redirect_to(root_url)
    end
    
    it "gives the right flash upon success" do
      post :create, { :password_reset => valid_email }
      expect(flash[:info]).to be_present
    end
    
    it "gives the right flash upon email location failure" do
      post :create, { :password_reset => invalid_email }
      expect(flash[:danger]).to be_present
    end
    
    it "redirects to new upon email location failure" do
      post :create, { :password_reset => invalid_email }
      expect(response).to render_template("new")
    end
    
    it "gives the right flash upon email sending failure" do
      PasswordMailer.any_instance.stub(:reset_email).and_raise(Net::SMTPAuthenticationError)
      post :create, { :password_reset => valid_email }
      expect(flash[:alert]).to be_present
    end
    
    it "redirects to new upon email sending failure" do
      PasswordMailer.any_instance.stub(:reset_email).and_raise(Net::SMTPAuthenticationError)
      post :create, { :password_reset => valid_email }
      expect(response).to render_template("new")
    end
    
  end
end
