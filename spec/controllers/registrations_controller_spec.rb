require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
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
	  it "redirects to the email confirmation page" do
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
