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

RSpec.describe ParticipantsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Participant. As you add validations to Participant, be sure to
  # adjust the attributes here as well.
  before(:all){	
    @c = Conference.create!(start_date: Date.parse("2015-4-4"), 
	  end_date: Date.parse("2015-6-6"),
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
	  :team_name => "PartControllerTest" 
	  )
  
    @p2 = Participant.create!(captain: false, shirt_size: "large",
			phone: "1876543211", team: @team)
			
    @admin = Administrator.create!()  
	
    @p2.create_account!(first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword")
			
	@admin.create_account!(first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin")		
  }	
  after(:all){
	@p2.account.delete
	@admin.account.delete
	@team.delete unless @team == nil
	@c.delete
	@p2.delete
	@admin.delete
  }
  
  let(:valid_attributes) { {
    :captain => false, 
	:shirt_size => "medium", 
	:phone => "1234567890",
	:team => @team
	}
  }

  let(:invalid_attributes) {{
    :captain => false, 
	:shirt_size => "", 
	:phone => "1234567890"
	}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ParticipantsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
  
    it "assigns all participants as @participants" do 
      log_in_as(@admin.account)	
      participant = Participant.create! valid_attributes
	  participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
      get :index, {}, valid_session
      expect(assigns(:participants)).to include(participant)
	  participant.account.delete
    end
	
	it "redirects index when account is not admin" do
      participant = Participant.create! valid_attributes
	  log_in_as(@p2.account)
      get :index, {}, valid_session
	  expect(response).to redirect_to(root_url)
    end
	
	it "redirects index when not logged in" do
	  participant = Participant.create! valid_attributes
	  get :index, {}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
	end
  end

  describe "GET #show" do
    it "assigns the requested participant as @participant" do
      participant = Participant.create! valid_attributes
	  participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	  log_in_as(participant.account)		
      get :show, {:id => participant.to_param}, valid_session
      expect(assigns(:participant)).to eq(participant)
	  participant.account.delete
    end
	
	it "does not redirect for an admin" do
	  participant = Participant.create! valid_attributes
	  participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	  log_in_as(@admin.account)
	  get :show, {:id => participant.to_param}, valid_session
      expect(assigns(:participant)).to eq(participant)
	  participant.account.delete
	end
	
	it "redirects show when not logged in" do
      participant = Participant.create! valid_attributes
      get :show, {:id => participant.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects show when wrong user" do
      participant = Participant.create! valid_attributes
	  log_in_as(@p2.account)
      get :show, {:id => participant.to_param}, valid_session
      expect(flash).to_not be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #new" do
    it "assigns a new participant as @participant" do
      get :new, {}, valid_session
      expect(assigns(:participant)).to be_a_new(Participant)
    end
  end

  describe "GET #edit" do
    it "assigns the requested participant as @participant" do
      participant = Participant.create! valid_attributes
	  participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	  log_in_as(participant.account)
      get :edit, {:id => participant.to_param}, valid_session
      expect(assigns(:participant)).to eq(participant)
	  participant.account.delete
    end
	
	it "does not redirect for an admin" do
	  participant = Participant.create! valid_attributes
	  log_in_as(@admin.account)
      get :edit, {:id => participant.to_param}, valid_session
      expect(assigns(:participant)).to eq(participant)
	end
	
	it "redirects edit when not logged in" do
      participant = Participant.create! valid_attributes
      get :edit, {:id => participant.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects edit when wrong user" do
      participant = Participant.create! valid_attributes
	  log_in_as(@p2.account)
      get :edit, {:id => participant.to_param}, valid_session
      expect(flash).to_not be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Participant" do
        expect {
          post :create, {:participant => valid_attributes}, valid_session
        }.to change(Participant, :count).by(1)
      end

      it "assigns a newly created participant as @participant" do
        post :create, {:participant => valid_attributes}, valid_session
        expect(assigns(:participant)).to be_a(Participant)
        expect(assigns(:participant)).to be_persisted
      end

      it "redirects to the created participant" do
        post :create, {:participant => valid_attributes}, valid_session
        expect(response).to redirect_to(Participant.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved participant as @participant" do
        post :create, {:participant => invalid_attributes}, valid_session
        expect(assigns(:participant)).to be_a_new(Participant)
      end

      it "re-renders the 'new' template" do
        post :create, {:participant => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {
		:captain => true, 
		:shirt_size => "medium", 
		:phone => "1234567890"
		}
      }

      it "updates the requested participant" do
        participant = Participant.create! valid_attributes
		participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	    log_in_as(participant.account)
        put :update, {:id => participant.to_param, :participant => new_attributes}, valid_session
        participant.reload
        expect(assigns(:participant)).to eq(participant)
		participant.account.delete
      end

      it "assigns the requested participant as @participant" do
        participant = Participant.create! valid_attributes
		participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	    log_in_as(participant.account)
        put :update, {:id => participant.to_param, :participant => valid_attributes}, valid_session
        expect(assigns(:participant)).to eq(participant)
		participant.account.delete
      end

      it "redirects to the participant" do
        participant = Participant.create! valid_attributes
		participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	    log_in_as(participant.account)
        put :update, {:id => participant.to_param, :participant => valid_attributes}, valid_session
        expect(response).to redirect_to(participant)
		participant.account.delete
      end
	  
	  it "does not redirect for an admin" do
	    participant = Participant.create! valid_attributes
	    log_in_as(@admin.account)
        put :update, {:id => participant.to_param, :participant => new_attributes}, valid_session
        participant.reload
        expect(assigns(:participant)).to eq(participant)
	  end
	  
	  it "redirects update when not logged in" do
	    participant = Participant.create! valid_attributes
        put :update, {:id => participant.to_param, :participant => valid_attributes}, valid_session
		flash.should_not be_nil
        expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects update when wrong user" do
	    participant = Participant.create! valid_attributes
		log_in_as(@p2.account)
        put :update, {:id => participant.to_param, :participant => valid_attributes}, valid_session
		flash.should_not be_nil
        expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns the participant as @participant" do
        participant = Participant.create! valid_attributes
		participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	    log_in_as(participant.account)
        put :update, {:id => participant.to_param, :participant => invalid_attributes}, valid_session
        expect(assigns(:participant)).to eq(participant)
		participant.account.delete
      end

      it "re-renders the 'edit' template" do
        participant = Participant.create! valid_attributes
		participant.create_account!(first_name: "A", last_name: "Z", email: "part@example.com",
			password: "mypassword", password_confirmation: "mypassword")
	    log_in_as(participant.account)
        put :update, {:id => participant.to_param, :participant => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
		participant.account.delete
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested participant" do
	  log_in_as(@admin.account)
      participant = Participant.create! valid_attributes
      expect {
        delete :destroy, {:id => participant.to_param}, valid_session
      }.to change(Participant, :count).by(-1)
    end

    it "redirects to the participants list" do
	  log_in_as(@admin.account)
      participant = Participant.create! valid_attributes
      delete :destroy, {:id => participant.to_param}, valid_session
      expect(response).to redirect_to(participants_url)
    end
	
	it "redirects destroy when not logged in" do
	  participant = Participant.create! valid_attributes
      delete :destroy, {:id => participant.to_param}, valid_session
      expect(response).to redirect_to(login_url)
	end
	
	it "redirects destroy when account is not an admin" do
	  participant = Participant.create! valid_attributes
	  log_in_as(@p2.account)
      delete :destroy, {:id => participant.to_param}, valid_session
      expect(response).to redirect_to(root_url)
	end
  end

end
