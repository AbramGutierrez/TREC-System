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

RSpec.describe AccountsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Account. As you add validations to Account, be sure to
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
    # @p = Participant.create!(captain: false, shirt_size: "M", 
			# phone: "1234567890", team: @team)	
			
    @p2 = Participant.create!(captain: false, shirt_size: "L",
			phone: "1876543211", team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"})
			
    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"})  
			
  }	
  after(:all){
	@team.destroy
	@c.destroy
	@p2.destroy
	@admin.destroy
  }  
			
  	

  let(:valid_attributes) { {
    :email => "testing@example.com",
	:password => "password",
	:password_confirmation => "password",
	:first_name => "First",
    :last_name => "Last"
    }
  }

  let(:invalid_attributes) { {
    :email => "bad_email",
	:password => "123",
	:password_confirmation => "123",
	:first_name => "First",
    :last_name => "Last"
	}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AccountsController. Be sure to keep this updated too.
  let(:valid_session) {}  

  describe "GET #index" do
    it "assigns all accounts as @accounts" do
	  account = Account.create! valid_attributes
	  log_in_as(@admin.account)
      get :index, {}, valid_session
	  expect(assigns(:accounts)).to include(account)
	end
	
    it "redirects index when account is not admin" do
      account = Account.create! valid_attributes
	  log_in_as(@p2.account)
      get :index, {}, valid_session
	  expect(response).to redirect_to(root_url)
    end
	
	it "redirects index when not logged in" do
	  account = Account.create! valid_attributes
	  get :index, {}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
	end
  end

  describe "GET #show" do
    it "assigns the requested account as @account" do
      account = Account.create! valid_attributes
	  p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", team: @team, account: account)
	  log_in_as(p.account)
      get :show, {:id => account.to_param}, valid_session
      expect(assigns(:account)).to eq(account)
	  p.destroy
    end
	
	it "redirects show when not logged in" do
      account = Account.create! valid_attributes
      get :show, {:id => account.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects show when wrong user" do
      account = Account.create! valid_attributes
	  log_in_as(@p2.account)
      get :show, {:id => account.to_param}, valid_session
      expect(flash).to_not be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #new" do
    it "assigns a new account as @account" do
      get :new, {}, valid_session
      expect(assigns(:account)).to be_a_new(Account)
    end
  end

  describe "GET #edit" do
    it "assigns the requested account as @account" do
      account = Account.create! valid_attributes
	  p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", team: @team, account: account)
	  log_in_as(p.account)
      get :edit, {:id => account.to_param}, valid_session
      expect(assigns(:account)).to eq(account)
	  p.destroy
    end
	
	it "redirects edit when not logged in" do
      account = Account.create! valid_attributes
      get :edit, {:id => account.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects edit when wrong user" do
      account = Account.create! valid_attributes
	  log_in_as(@p2.account)
      get :edit, {:id => account.to_param}, valid_session
      expect(flash).to_not be_nil
      expect(response).to redirect_to(root_url)
    end
	
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Account" do
        expect {
          post :create, {:account => valid_attributes}, valid_session
        }.to change(Account, :count).by(1)
      end

      it "assigns a newly created account as @account" do
        post :create, {:account => valid_attributes}, valid_session
        expect(assigns(:account)).to be_a(Account)
        expect(assigns(:account)).to be_persisted
      end

      it "redirects to the created account" do
        post :create, {:account => valid_attributes}, valid_session
        expect(response).to redirect_to(Account.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(assigns(:account)).to be_a_new(Account)
      end

      it "re-renders the 'new' template" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {
        :email => "test2@example.com",
		:password => "password",
		:password_confirmation => "password",
		:first_name => "FirstName",
		:last_name => "LastName"
    }
      }

      it "updates the requested account" do
	    
        account = Account.create! valid_attributes
		p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", team: @team, account: account)
		log_in_as(p.account)
        put :update, {:id => account.to_param, :account => new_attributes}, valid_session
        account.reload
        expect(assigns(:account)).to eq(account)
		p.destroy
      end

      it "assigns the requested account as @account" do
        account = Account.create! valid_attributes
		p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", team: @team, account: account)
		log_in_as(p.account)
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        expect(assigns(:account)).to eq(account)
		p.destroy
      end

      it "redirects to the account" do
        account = Account.create! valid_attributes
		p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", team: @team, account: account)
		log_in_as(p.account)
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        expect(response).to redirect_to(account)
		p.destroy
      end
	  
	  it "redirects update when not logged in" do
	    account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
		expect(flash).to_not be_nil
        expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects update when wrong user" do
	    account = Account.create! valid_attributes
		log_in_as(@p2.account)
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
		expect(flash).to_not be_nil
        expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns the account as @account" do
        account = Account.create! valid_attributes
		p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", team: @team, account: account)
		log_in_as(p.account)
        put :update, {:id => account.to_param, :account => invalid_attributes}, valid_session
        expect(assigns(:account)).to eq(account)
		p.destroy
      end

      it "re-renders the 'edit' template" do
        account = Account.create! valid_attributes
		p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", team: @team, account: account)
		log_in_as(p.account)
        put :update, {:id => account.to_param, :account => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
		p.destroy
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested account" do
      account = Account.create! valid_attributes
	  log_in_as(@admin.account)
      expect {
        delete :destroy, {:id => account.to_param}, valid_session
      }.to change(Account, :count).by(-1)
    end

    it "redirects to the accounts list" do
      account = Account.create! valid_attributes
	  log_in_as(@admin.account)
      delete :destroy, {:id => account.to_param}, valid_session
      expect(response).to redirect_to(accounts_url)
    end
	
	it "redirects destroy when not logged in" do
	  account = Account.create! valid_attributes
      delete :destroy, {:id => account.to_param}, valid_session
      expect(response).to redirect_to(login_url)
	end
	
	it "redirects destroy when account is not an admin" do
	  account = Account.create! valid_attributes
	  log_in_as(@p2.account)
      delete :destroy, {:id => account.to_param}, valid_session
      expect(response).to redirect_to(root_url)
	end
  end

end
