require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ConferencesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Conference. As you add validations to Conference, be sure to
  # adjust the attributes here as well.
  
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
	@c.destroy
	@team.destroy
	@admin.destroy
	@p.destroy
	first = Conference.first
	first.is_active = true
	first.save!
  } 
  
  let(:valid_attributes) { {
	:start_date => Date.parse("2016-4-4"),
	:end_date => Date.parse("2016-6-6"),
	:conf_start_date => Date.parse("2016-6-8"),
	:conf_end_date => Date.parse("2016-6-9"),
	:max_team_size => 6,
	:min_team_size => 1,
	:max_teams => 5,
	:tamu_cost => 30.00,
	:other_cost => 60.00,
	:challenge_desc => 'yay!',
	:is_active => true
	}  
  }
  
  let(:inactive_attributes) { {
	:start_date => Date.parse("2015-7-7"),
	:end_date => Date.parse("2015-8-8"),
	:conf_start_date => Date.parse("2015-8-8"),
	:conf_end_date => Date.parse("2015-8-9"),
	:max_team_size => 6,
	:min_team_size => 1,
	:max_teams => 5,
	:tamu_cost => 30.00,
	:other_cost => 60.00,
	:challenge_desc => 'yay!',
	:is_active => false
	}  
  }

  let(:invalid_attributes) { {
	:start_date => "",
	:end_date => Date.parse("2015-6-6"),
	:max_team_size => 6,
	:min_team_size => 1,
	:max_teams => 5,
	:tamu_cost => 30.00,
	:other_cost => 60.00,
	:challenge_desc => 'yay!',
	:is_active => true
	}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ConferencesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all conferences as @conferences" do
	  log_in_as(@admin.account)
      conference = Conference.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:conferences)).to include(conference)
    end
	
	it "redirects index when account is not admin" do
      conference = Conference.create! valid_attributes
	  log_in_as(@p.account)
      get :index, {}, valid_session
	  expect(response).to redirect_to(root_url)
    end
	
	it "redirects index when not logged in" do
	  conference = Conference.create! valid_attributes
	  get :index, {}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
	end
  end

  describe "GET #show" do
    it "assigns the requested conference as @conference" do
	  log_in_as(@admin.account)
      conference = Conference.create! valid_attributes
      get :show, {:id => conference.to_param}, valid_session
      expect(assigns(:conference)).to eq(conference)
    end
	
	it "allows participants to view the current conference" do
	  log_in_as(@p.account)
      conference = Conference.create! valid_attributes
      get :show, {:id => conference.to_param}, valid_session
      expect(assigns(:conference)).to eq(conference)
    end
	
	it "redirects show when not logged in" do
	  conference = Conference.create! valid_attributes
      get :show, {:id => conference.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects show when not an admin and conference not active" do
	  conference = Conference.create! inactive_attributes
	  log_in_as(@p.account)
      get :show, {:id => conference.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "GET #new" do
    it "assigns a new conference as @conference" do
	  log_in_as(@admin.account)
      get :new, {}, valid_session
      expect(assigns(:conference)).to be_a_new(Conference)
    end
	
	it "redirects new when not logged in" do
	  get :new, {}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects new when not an admin" do
	  log_in_as(@p.account)
	  get :new, {}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "GET #edit" do
    it "assigns the requested conference as @conference" do
	  log_in_as(@admin.account)
      conference = Conference.create! valid_attributes
      get :edit, {:id => conference.to_param}, valid_session
      expect(assigns(:conference)).to eq(conference)
    end
	
	it "redirects edit when not logged in" do
	  conference = Conference.create! valid_attributes
	  get :edit, {:id => conference.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects edit when not an admin" do
	  conference = Conference.create! valid_attributes
	  log_in_as(@p.account)
	  get :edit, {:id => conference.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Conference" do
	    log_in_as(@admin.account)
        expect {
          post :create, {:conference => valid_attributes}, valid_session
        }.to change(Conference, :count).by(1)
      end

      it "assigns a newly created conference as @conference" do
	    log_in_as(@admin.account)
        post :create, {:conference => valid_attributes}, valid_session
        expect(assigns(:conference)).to be_a(Conference)
        expect(assigns(:conference)).to be_persisted
      end

      it "redirects to the created conference" do
	    log_in_as(@admin.account)
        post :create, {:conference => valid_attributes}, valid_session
        expect(response).to redirect_to(Conference.last)
      end
	  
	  it "redirects create when not logged in" do
	    post :create, {:conference => valid_attributes}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects create when not an admin" do
	    log_in_as(@p.account)
		post :create, {:conference => valid_attributes}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved conference as @conference" do
	    log_in_as(@admin.account)
        post :create, {:conference => invalid_attributes}, valid_session
        expect(assigns(:conference)).to be_a_new(Conference)
      end

      it "re-renders the 'new' template" do
	    log_in_as(@admin.account)
        post :create, {:conference => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {
		:start_date => Date.parse("2015-4-4"),
		:end_date => Date.parse("2015-6-6"),
		conf_start_date: Date.parse("2015-6-8"),
	    conf_end_date: Date.parse("2015-6-9"),
		:max_team_size => 8,
		:min_team_size => 1,
		:max_teams => 15,
		:tamu_cost => 40.00,
		:other_cost => 50.00,
		:challenge_desc => 'yay!',
		:created_at => DateTime.parse("2015-4-3"),
		:updated_at => DateTime.parse("2015-4-3"),
		:is_active => true
	    } 
      }

      it "updates the requested conference" do
	    log_in_as(@admin.account)
        conference = Conference.create! valid_attributes
        put :update, {:id => conference.to_param, :conference => new_attributes}, valid_session
        conference.reload
		expect(assigns(:conference)).to eq(conference)
      end

      it "assigns the requested conference as @conference" do
	    log_in_as(@admin.account)
        conference = Conference.create! valid_attributes
        put :update, {:id => conference.to_param, :conference => valid_attributes}, valid_session
        expect(assigns(:conference)).to eq(conference)
      end

      it "redirects to the conference" do
	    log_in_as(@admin.account)
        conference = Conference.create! valid_attributes
        put :update, {:id => conference.to_param, :conference => valid_attributes}, valid_session
        expect(response).to redirect_to(conference)
      end
	  
	  it "redirects update when not logged in" do
	    conference = Conference.create! valid_attributes
		put :update, {:id => conference.to_param, :conference => valid_attributes}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects update when not an admin" do
	    conference = Conference.create! valid_attributes
		log_in_as(@p.account)
		put :update, {:id => conference.to_param, :conference => valid_attributes}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns the conference as @conference" do
	    log_in_as(@admin.account)
        conference = Conference.create! valid_attributes
        put :update, {:id => conference.to_param, :conference => invalid_attributes}, valid_session
        expect(assigns(:conference)).to eq(conference)
      end

      it "re-renders the 'edit' template" do
	    log_in_as(@admin.account)
        conference = Conference.create! valid_attributes
        put :update, {:id => conference.to_param, :conference => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested conference" do
	  log_in_as(@admin.account)
      conference = Conference.create! valid_attributes
      expect {
        delete :destroy, {:id => conference.to_param}, valid_session
      }.to change(Conference, :count).by(-1)
    end

    it "redirects to the conferences list" do
	  log_in_as(@admin.account)
      conference = Conference.create! valid_attributes
      delete :destroy, {:id => conference.to_param}, valid_session
      expect(response).to redirect_to(conferences_url)
    end
	
	it "redirects destroy when not logged in" do
	  conference = Conference.create! valid_attributes
	  delete :destroy, {:id => conference.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects destroy when not an admin" do
	  log_in_as(@p.account)
	  conference = Conference.create! valid_attributes
	  delete :destroy, {:id => conference.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end  
  end

end
