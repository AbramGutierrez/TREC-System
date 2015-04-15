require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "GET #new" do
	before(:example) do
      get :new
	end
	
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
    end
	
	context "when there is a active conference" do
	  it "assigns @conference" do
	  end
	  
	  it "renders the new template" do
	    expect(response).to render_template("new")
	  end
	end
	
	context "when there is no active conference" do
	  it "renders the fail template" do
		#expect(assigns(:conference)).not_to eq(conference)
	  end
	end
	
  end
  
  describe "POST #create" do
    before(:example) do
      post :create 
	end
	
	context "when valid" do
	  it "renders the email conformation page"
	    expect(response).to render_template("success")
	  end
	end
	
	context "when invalid" do
	end
	
  end
  describe "GET #success" do
  end
  describe "GET #fail" do
  end
  
end
