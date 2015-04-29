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

RSpec.describe AdministratorsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Administrator. As you add validations to Administrator, be sure to
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
	  :team_name => "ControllerTest" 
	  )  
    @p = Participant.create!(captain: false, shirt_size: "Medium", 
			phone: "1234567890", team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"}) 
    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"})
			
  }	
  
  # after(:each){
    # a = Account.where(email: "adminControllerSpec@example.com")
    # if a != nil
	  # puts "grrr\n"
	  # a.destroy_all
	# end  
  # }
  
  after(:all){
	@p.destroy
	@team.destroy
	@c.destroy
	@admin.destroy
  } 
  
  let(:valid_attributes) { {account_attributes: {
	  first_name: "an",
	  last_name: "admin",
	  email: "adminControllerSpec@example.com",
	  password: "admin",
	  password_confirmation: "admin"
	}} 
  }

  let(:invalid_attributes) {
    {account_attributes: {
	  first_name: "an",
	  last_name: "admin",
	  email: "invalid email",
	  password: "admin",
	  password_confirmation: "admin"
	}} 
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdministratorsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all administrators as @administrators" do
      administrator = Administrator.create! valid_attributes
	  log_in_as(administrator.account)		
      get :index, {}, valid_session
      expect(assigns(:administrators)).to include(administrator)
    end
	
	it "redirects index when account is not admin" do
      administrator = Administrator.create! valid_attributes
	  log_in_as(@p.account)
      get :index, {}, valid_session
	  expect(response).to redirect_to(root_url)
    end
	
	it "redirects index when not logged in" do
	  administrator = Administrator.create! valid_attributes
	  get :index, {}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
	end
  end

  describe "GET #show" do
    it "assigns the requested administrator as @administrator" do
      administrator = Administrator.create! valid_attributes
	  log_in_as(administrator.account)
      get :show, {:id => administrator.to_param}, valid_session
      expect(assigns(:administrator)).to eq(administrator)
    end
	
	it "redirects show when not logged in" do
	  administrator = Administrator.create! valid_attributes
      get :show, {:id => administrator.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects show when not an admin" do
	  administrator = Administrator.create! valid_attributes
	  log_in_as(@p.account)
      get :show, {:id => administrator.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "GET #new" do
    it "assigns a new administrator as @administrator" do
	  admin = Administrator.create! valid_attributes
	  log_in_as(admin.account)
      get :new, {}, valid_session
      expect(assigns(:administrator)).to be_a_new(Administrator)
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
    it "assigns the requested administrator as @administrator" do
      administrator = Administrator.create! valid_attributes
	  log_in_as(administrator.account)		
      get :edit, {:id => administrator.to_param}, valid_session
      expect(assigns(:administrator)).to eq(administrator)
    end
	
	it "redirects edit when not logged in" do
	  administrator = Administrator.create! valid_attributes
	  get :edit, {:id => administrator.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects edit when not an admin" do
	  administrator = Administrator.create! valid_attributes
	  log_in_as(@p.account)
	  get :edit, {:id => administrator.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Administrator" do
		log_in_as(@admin.account)	
        expect {
          post :create, {:administrator => valid_attributes}, valid_session
        }.to change(Administrator, :count).by(1)
      end

      it "assigns a newly created administrator as @administrator" do
		log_in_as(@admin.account)
        post :create, {:administrator => valid_attributes}, valid_session
        expect(assigns(:administrator)).to be_a(Administrator)
        expect(assigns(:administrator)).to be_persisted
      end

      it "redirects to the created administrator" do
		log_in_as(@admin.account)
        post :create, {:administrator => valid_attributes}, valid_session
        expect(response).to redirect_to(Administrator.last)
      end
	  
	  it "redirects create when not logged in" do
	    post :create, {:administrator => valid_attributes}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects create when not an admin" do
	    log_in_as(@p.account)
		post :create, {:administrator => valid_attributes}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved administrator as @administrator" do
	    admin = Administrator.create! valid_attributes
		log_in_as(admin.account)
        post :create, {:administrator => invalid_attributes}, valid_session
        expect(assigns(:administrator)).to be_a_new(Administrator)
      end

      it "re-renders the 'new' template" do
	    admin = Administrator.create! valid_attributes
		log_in_as(admin.account)
        post :create, {:administrator => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{account_attributes: {
		  first_name: "new",
		  last_name: "admin",
		  email: "adminControllerSpec2@example.com",
		  password: "admin",
		  password_confirmation: "admin"
		}
		}
      }

      it "updates the requested administrator" do
        administrator = Administrator.create! valid_attributes
	    log_in_as(administrator.account)
        put :update, {:id => administrator.to_param, :administrator => new_attributes}, valid_session
        administrator.reload
        expect(assigns(:administrator)).to eq(administrator)
      end

      it "assigns the requested administrator as @administrator" do
        administrator = Administrator.create! valid_attributes
	    log_in_as(administrator.account)
        put :update, {:id => administrator.to_param, :administrator => valid_attributes}, valid_session
        expect(assigns(:administrator)).to eq(administrator)
      end

      it "redirects to the administrator" do
        administrator = Administrator.create! valid_attributes
	    log_in_as(administrator.account)
        put :update, {:id => administrator.to_param, :administrator => valid_attributes}, valid_session
        expect(response).to redirect_to(administrator)
      end
	  
	  it "redirects update when not logged in" do
	    administrator = Administrator.create! valid_attributes
		put :update, {:id => administrator.to_param, :administrator => valid_attributes}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects update when not an admin" do
	    administrator = Administrator.create! valid_attributes
		log_in_as(@p.account)
		put :update, {:id => administrator.to_param, :administrator => valid_attributes}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns the administrator as @administrator" do
        administrator = Administrator.create! valid_attributes
	    log_in_as(administrator.account)
        put :update, {:id => administrator.to_param, :administrator => invalid_attributes}, valid_session
        expect(assigns(:administrator)).to eq(administrator)
      end

      it "re-renders the 'edit' template" do
        administrator = Administrator.create! valid_attributes
	    log_in_as(administrator.account)
		put :update, {:id => administrator.to_param, :administrator => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested administrator" do
	  log_in_as(@admin.account)
      administrator = Administrator.create! valid_attributes
      expect {
        delete :destroy, {:id => administrator.to_param}, valid_session
      }.to change(Administrator, :count).by(-1)
    end

    it "redirects to the administrators list" do
      log_in_as(@admin.account)
      administrator = Administrator.create! valid_attributes
      delete :destroy, {:id => administrator.to_param}, valid_session
      expect(response).to redirect_to(administrators_url)
    end
	
	it "redirects destroy when not logged in" do
	  administrator = Administrator.create! valid_attributes
	  delete :destroy, {:id => administrator.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects destroy when not an admin" do
	  log_in_as(@p.account)
	  administrator = Administrator.create! valid_attributes
	  delete :destroy, {:id => administrator.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

end
