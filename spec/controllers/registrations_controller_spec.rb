require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  	let(:valid_team){ {
	    team_name: "RegistrationTestTeam",
		school: "TestSchool"
	  }
	}  
	
	let(:invalid_team){ {
	    team_name: "",
		school: "TestSchool"
	  }
	} 
	
	before(:all) do
	    @valid_participants = Hash.new
	    @valid_participants[0] = {captain: true, phone: "9999999999", shirt_size: "Small", first_name: "participant1", last_name: "participant1", email: "partici1@example.com"}
	    @valid_participants[1] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant2", last_name: "participant2", email: "partici2@example.com"}
	    @valid_participants[2] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant3", last_name: "participant3", email: "partici3@example.com"}
	    @valid_participants[3] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant4", last_name: "participant4", email: "partici4@example.com"}
	    @valid_participants[4] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant5", last_name: "participant5", email: "partici5@example.com"}
	    @valid_participants[5] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant6", last_name: "participant6", email: "partici6@example.com"}
		@participants_no_captain = Hash.new
	    @participants_no_captain[0] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant1", last_name: "participant1", email: "partici1@example.com"}
	    @participants_no_captain[1] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant2", last_name: "participant2", email: "partici2@example.com"}
	    @participants_no_captain[2] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant3", last_name: "participant3", email: "partici3@example.com"}
	    @participants_no_captain[3] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant4", last_name: "participant4", email: "partici4@example.com"}
	    @participants_no_captain[4] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant5", last_name: "participant5", email: "partici5@example.com"}
	    @participants_no_captain[5] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant6", last_name: "participant6", email: "partici6@example.com"}
		@participants_no_phone = Hash.new
	    @participants_no_phone[0] = {captain: true, phone: "9999999999", shirt_size: "Small", first_name: "participant1", last_name: "participant1", email: "partici1@example.com"}
	    @participants_no_phone[1] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant2", last_name: "participant2", email: "partici2@example.com"}
	    @participants_no_phone[2] = {captain: false, phone: "", shirt_size: "Small", first_name: "participant3", last_name: "participant3", email: "partici3@example.com"}
	    @participants_no_phone[3] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant4", last_name: "participant4", email: "partici4@example.com"}
	    @participants_no_phone[4] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant5", last_name: "participant5", email: "partici5@example.com"}
	    @participants_no_phone[5] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant6", last_name: "participant6", email: "partici6@example.com"}
		@participants_no_email = Hash.new
	    @participants_no_email[0] = {captain: true, phone: "9999999999", shirt_size: "Small", first_name: "participant1", last_name: "participant1", email: "partici1@example.com"}
	    @participants_no_email[1] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant2", last_name: "participant2", email: "partici2@example.com"}
	    @participants_no_email[2] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant3", last_name: "participant3", email: "partici3@example.com"}
	    @participants_no_email[3] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant4", last_name: "participant4", email: "partici4@example.com"}
	    @participants_no_email[4] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant5", last_name: "participant5", email: "partici5@example.com"}
	    @participants_no_email[5] = {captain: false, phone: "9999999999", shirt_size: "Small", first_name: "participant6", last_name: "participant6", email: ""}
		@conference = Conference.create!(start_date: Date.parse("2015-6-4"), 
		  end_date: Date.parse("2015-7-6"),
		  max_team_size: 6,
		  min_team_size: 1,
		  max_teams: 5,
		  tamu_cost: 30.00,
		  other_cost: 60.00,
		  challenge_desc: 'testing!',
		  is_active: true
		  )
	end
	
	after(:all) {
		@conference.destroy
	}
	
	let(:valid_session) { {} }

  describe "GET #new" do

	before(:example) do
      get :new
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
	  it "sets a error message and renders new for invalid team" do
	    post :create, {:team => invalid_team, :participants => @valid_participants}, valid_session
	    expect(flash[:alert]).to be_present
		expect(response).to render_template("new")
	  end
	  
	  it "sets a error message and renders new for no captain" do
	    post :create, {:team => valid_team, :participants => @participants_no_captain}, valid_session
	    expect(flash[:alert]).to be_present
		expect(response).to render_template("new")
	  end
	  
	  it "sets a error message and renders new for no phone" do
	    post :create, {:team => valid_team, :participants => @participants_no_phone}, valid_session
	    expect(flash[:alert]).to be_present
		expect(response).to render_template("new")
	  end
	  
	  it "sets a error message and renders new for no email" do
	    post :create, {:team => valid_team, :participants => @participants_no_email}, valid_session
	    expect(flash[:alert]).to be_present
		expect(response).to render_template("new")
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
