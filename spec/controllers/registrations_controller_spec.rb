require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  	let(:valid_team){ {
	    team_name: "RegistrationTestTeam",
		school: "TestSchool"
	  }
	}  
	
	before(:all) do
	    @valid_participants = Hash.new
	    @valid_participants[0] = {captain: true, phone: "9999999999", shirt_size: "S", first_name: "participant1", last_name: "participant1", email: "partici1@example.com"}
	    @valid_participants[1] = {captain: false, phone: "9999999999", shirt_size: "S", first_name: "participant2", last_name: "participant2", email: "partici2@example.com"}
	    @valid_participants[2] = {captain: false, phone: "9999999999", shirt_size: "S", first_name: "participant3", last_name: "participant3", email: "partici3@example.com"}
	    @valid_participants[3] = {captain: false, phone: "9999999999", shirt_size: "S", first_name: "participant4", last_name: "participant4", email: "partici4@example.com"}
	    @valid_participants[4] = {captain: false, phone: "9999999999", shirt_size: "S", first_name: "participant5", last_name: "participant5", email: "partici5@example.com"}
	    @valid_participants[5] = {captain: false, phone: "9999999999", shirt_size: "S", first_name: "participant6", last_name: "participant6", email: "partici6@example.com"}
	end
	
	let(:valid_session) { {} }

  describe "GET #new" do
    before(:all) do
	  @conference = Conference.create!(start_date: Date.parse("2015-4-4"), 
	  end_date: Date.parse("2015-6-6"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 5,
	  tamu_cost: 30.00,
	  other_cost: 60.00,
	  challenge_desc: 'yay!',
	  is_active: true
	  )
	end
	before(:example) do
      get :new
	end
	
	after(:all) do
	  @conference.delete
	end

	
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
    end
	
	context "when there is a active conference" do 
	  it "assigns @conference" do
	    #expect(assigns(:conference)).to be_a_new(Conference)
	  end
	  
	  it "renders the new template" do
        expect(response).to render_template("new")
      end
	  
	end
	
  end
  
  describe "POST #create" do
    before(:example) do
      #post :create 
	end

	
	context "when valid" do
	  	
	  it "successfully creates the team" do
	    original_count = Team.count
        post :create, {:team => valid_team, :participants => @valid_participants}, valid_session
        expect(Team.count).to be(original_count+1)
	  end	
		
	  it "successfully creates the participants" do
	    original_count = Participant.count
        post :create, {:team => valid_team, :participants => @valid_participants}, valid_session
        expect(Participant.count).to be(original_count+6)
	  end
	  
	  it "redirects to the success page" do
	    post :create, {:team => valid_team, :participants => @valid_participants}, valid_session
		expect(response).to redirect_to('/registrations/success')
	  end
	end
	
	context "when invalid" do
	  it "sets a error message" do
	    #expect(flash[:error]).to be_present
	  end
	  
	  it "renders the new template" do
	    #expect(response).to render_template("new")
	  end
	end
	
  end
  
  describe "GET #success" do
    before(:example) do
      get :success
	end
	
    it "renders the success template" do
	    expect(response).to render_template("success")
	end
  end
  
  describe "GET #fail" do
    before(:example) do
      get :fail
	end
	
    it "renders the fail template" do
	  expect(response).to render_template("fail")
    end
  end
  
end
