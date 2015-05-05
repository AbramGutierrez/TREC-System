require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  before(:all){	
    @c = Conference.create!(start_date: Date.parse("2015-4-4"), 
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
  
	@team = Team.create!(:conference => @c,	
	  :school => "TestSchool",
	  :paid_status => "paid", 
	  :team_name => "ControllerTest" 
	  )    
			
    @p = Participant.create!(captain: false, shirt_size: "L",
			phone: "1876543211", phone_provider: "3 River Wireless",
			team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"})
			
    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"})  
			
  }	
  after(:all){
	@team.destroy
	@c.destroy
	@p.destroy
	@admin.destroy
  }	
  
  let(:valid_attributes) { {
    :name => "TestSchoolController"
    }
  }
  
  let(:invalid_attributes) { {:name => ""} }
  
  let(:valid_session) {}  

  describe "GET #index" do
	it "assigns all schools as @schools" do
	  school = School.create! valid_attributes
	  log_in_as(@admin.account)
      get :index, {}, valid_session
	  expect(assigns(:schools)).to include(school)
	end
	
    it "redirects index when account is not admin" do
      school = School.create! valid_attributes
	  log_in_as(@p.account)
      get :index, {}, valid_session
	  expect(response).to redirect_to(root_url)
    end
	
	it "redirects index when not logged in" do
	  school = School.create! valid_attributes
	  get :index, {}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
	end
  end

  describe "GET #show" do
	it "assigns the requested school as @school" do
      school = School.create! valid_attributes
	  log_in_as(@admin.account)
      get :show, {:id => school.to_param}, valid_session
      expect(assigns(:school)).to eq(school)
    end
	
	it "redirects show when not logged in" do
      school = School.create! valid_attributes
      get :show, {:id => school.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects show when not admin" do
	  school = School.create! valid_attributes
	  log_in_as(@p.account)
	  get :show, {:id => school.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(root_url)
	end
  end

  describe "GET #new" do
	it "assigns a new school as @school" do
	  log_in_as(@admin.account)
      get :new, {}, valid_session
      expect(assigns(:school)).to be_a_new(School)
    end
  end

  describe "GET #edit" do
	it "assigns the requested school as @school" do
      school = School.create! valid_attributes
	  log_in_as(@admin.account)
      get :edit, {:id => school.to_param}, valid_session
      expect(assigns(:school)).to eq(school)
    end
	
	it "redirects edit when not logged in" do
      school = School.create! valid_attributes
      get :edit, {:id => school.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects edit when not admin" do
      school = School.create! valid_attributes
	  log_in_as(@p.account)
      get :edit, {:id => school.to_param}, valid_session
      expect(flash).to_not be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe "POST #create" do
	context "with valid params" do
      it "creates a new School" do
	    log_in_as(@admin.account)
        expect {
          post :create, {:school => valid_attributes}, valid_session
        }.to change(School, :count).by(1)
      end

      it "assigns a newly created school as @school" do
	    log_in_as(@admin.account)
        post :create, {:school => valid_attributes}, valid_session
        expect(assigns(:school)).to be_a(School)
        expect(assigns(:school)).to be_persisted
      end

      it "redirects to the created school" do
	    log_in_as(@admin.account)
        post :create, {:school => valid_attributes}, valid_session
        expect(response).to redirect_to(schools_url)
      end
	  
	  it "redirects when not logged in" do
	    post :create, {:school => valid_attributes}, valid_session
		expect(flash).to_not be_nil
        expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects when not admin" do
	    log_in_as(@p.account)
	    post :create, {:school => valid_attributes}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved school as @school" do
	    log_in_as(@admin.account)
        post :create, {:school => invalid_attributes}, valid_session
        expect(assigns(:school)).to be_a_new(School)
      end

      it "re-renders the 'new' template" do
	    log_in_as(@admin.account)
        post :create, {:school => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
	context "with valid params" do
      let(:new_attributes) { {
        :name => "newName"
      }
      }

      it "updates the requested school" do
	    
        school = School.create! valid_attributes
		log_in_as(@admin.account)
        put :update, {:id => school.to_param, :school => new_attributes}, valid_session
        school.reload
        expect(assigns(:school)).to eq(school)
      end

      it "assigns the requested school as @school" do
        school = School.create! valid_attributes
		log_in_as(@admin.account)
        put :update, {:id => school.to_param, :school => valid_attributes}, valid_session
        expect(assigns(:school)).to eq(school)
      end

      it "redirects to the school" do
        school = School.create! valid_attributes
		log_in_as(@admin.account)
        put :update, {:id => school.to_param, :school => valid_attributes}, valid_session
        expect(response).to redirect_to(schools_url)
      end
	  
	  it "redirects update when not logged in" do
	    school = School.create! valid_attributes
        put :update, {:id => school.to_param, :school => valid_attributes}, valid_session
		expect(flash).to_not be_nil
        expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects update when not admin" do
	    log_in_as(@admin.account)
	    school = School.create! valid_attributes
	    log_in_as(@p.account)
        put :update, {:id => school.to_param, :school => new_attributes}, valid_session
        expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns the school as @school" do
        school = School.create! valid_attributes
		log_in_as(@admin.account)
        put :update, {:id => school.to_param, :school => invalid_attributes}, valid_session
        expect(assigns(:school)).to eq(school)
      end

      it "re-renders the 'edit' template" do
        school = School.create! valid_attributes
		log_in_as(@admin.account)
        put :update, {:id => school.to_param, :school => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested school" do
      school = School.create! valid_attributes
	  log_in_as(@admin.account)
      expect {
        delete :destroy, {:id => school.to_param}, valid_session
      }.to change(School, :count).by(-1)
    end

    it "redirects to the schools list" do
      school = School.create! valid_attributes
	  log_in_as(@admin.account)
      delete :destroy, {:id => school.to_param}, valid_session
      expect(response).to redirect_to(schools_url)
    end
	
	it "redirects destroy when not logged in" do
	  school = School.create! valid_attributes
      delete :destroy, {:id => school.to_param}, valid_session
      expect(response).to redirect_to(login_url)
	end
	
	it "redirects destroy when user is not an admin" do
	  school = School.create! valid_attributes
	  log_in_as(@p.account)
      delete :destroy, {:id => school.to_param}, valid_session
      expect(response).to redirect_to(root_url)
	end
  end	

end
