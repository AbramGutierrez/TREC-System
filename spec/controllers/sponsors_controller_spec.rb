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

RSpec.describe SponsorsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Sponsor. As you add validations to Sponsor, be sure to
  # adjust the attributes here as well.	
  before(:all){		
	@c = Conference.create!(start_date: Date.parse("2015-4-10"), 
	  end_date: Date.parse("2015-6-12"),
	  conf_start_date: Date.parse("2015-6-8"),
	  conf_end_date: Date.parse("2015-6-9"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 6,
	  tamu_cost: 20.00,
	  other_cost: 40.00,
	  challenge_desc: 'fun!',
	  is_active: true
	  )	
	  
	@team = Team.create!(:conference => @c,	
	  :school => "TestSchool",
	  :paid_status => "paid", 
	  :team_name => "ControllerTest" 
	  )  

	@p = Participant.create!(captain: false, shirt_size: "Large",
			phone: "1876543211", team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"})
			
    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"})  

    @start_date = Date.parse("2015-4-10")

	@valid_attributes2 = Hash.new
	@valid_attributes2[:conference] = Date.parse("2015-4-10")
	@valid_attributes2[:sponsor_name] = "Test"
	@valid_attributes2[:priority] = 1
	image = "/tamu.png"
    file = fixture_file_upload(image, "image/png")
	@valid_attributes2[:logo_path] = file
	
	@invalid_attributes = Hash.new
	@invalid_attributes[:conference] = Date.parse("2015-4-10")
	@invalid_attributes[:sponsor_name] = ""
	@invalid_attributes[:priority] = 1
	@invalid_attributes[:logo_path] = file
	
	@new_attributes = Hash.new
	@new_attributes[:conference] = Date.parse("2015-4-10")
	@new_attributes[:sponsor_name] = "Test"
	@new_attributes[:priority] = 5
	@new_attributes[:logo_path] = file
  }	
  after(:all){
	@team.destroy
	@c.destroy
	@admin.destroy
	@p.destroy
  }	
  
  let(:valid_attributes) { {
    :conference_id => @c.id,
	:sponsor_name => "Test",
	:logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif")),
	:priority => 1
	}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SponsorsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all sponsors as @sponsors" do
	  log_in_as(@admin.account)
      sponsor = Sponsor.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:sponsors)).to eq([sponsor])
    end
	
	it "redirects index when account is not admin" do
      sponsor = Sponsor.create! valid_attributes
	  log_in_as(@p.account)
      get :index, {}, valid_session
	  expect(response).to redirect_to(root_url)
    end
	
	it "redirects index when not logged in" do
	  sponsor = Sponsor.create! valid_attributes
	  get :index, {}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
	end
  end

  describe "GET #show" do
    it "assigns the requested sponsor as @sponsor" do
	  log_in_as(@admin.account)
      sponsor = Sponsor.create! valid_attributes
      get :show, {:id => sponsor.to_param}, valid_session
      expect(assigns(:sponsor)).to eq(sponsor)
    end
	
	it "redirects show when not logged in" do
	  sponsor = Sponsor.create! valid_attributes
      get :show, {:id => sponsor.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects show when not an admin" do
	  sponsor = Sponsor.create! valid_attributes
	  log_in_as(@p.account)
      get :show, {:id => sponsor.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "GET #new" do
    it "assigns a new sponsor as @sponsor" do
	  log_in_as(@admin.account)
      get :new, {}, valid_session
      expect(assigns(:sponsor)).to be_a_new(Sponsor)
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
    it "assigns the requested sponsor as @sponsor" do
	  log_in_as(@admin.account)
      sponsor = Sponsor.create! valid_attributes
      get :edit, {:id => sponsor.to_param}, valid_session
      expect(assigns(:sponsor)).to eq(sponsor)
    end
	
	it "redirects edit when not logged in" do
	  sponsor = Sponsor.create! valid_attributes
	  get :edit, {:id => sponsor.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects edit when not an admin" do
	  sponsor = Sponsor.create! valid_attributes
	  log_in_as(@p.account)
	  get :edit, {:id => sponsor.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Sponsor" do
	    log_in_as(@admin.account)
        expect {
          post :create, {:sponsor => @valid_attributes2}, valid_session
        }.to change(Sponsor, :count).by(1)
      end

      it "assigns a newly created sponsor as @sponsor" do
	    log_in_as(@admin.account)
        post :create, {:sponsor => @valid_attributes2}, valid_session
        expect(assigns(:sponsor)).to be_a(Sponsor)
        expect(assigns(:sponsor)).to be_persisted
      end

      it "redirects to the created sponsor" do
	    log_in_as(@admin.account)
        post :create, {:sponsor => @valid_attributes2}, valid_session
        expect(response).to redirect_to(Sponsor.last)
      end
	  
	  it "redirects create when not logged in" do
	    post :create, {:sponsor => @valid_attributes2}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects create when not an admin" do
	    log_in_as(@p.account)
		post :create, {:sponsor => @valid_attributes2}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved sponsor as @sponsor" do
	    log_in_as(@admin.account)
        post :create, {:sponsor => @invalid_attributes}, valid_session
        expect(assigns(:sponsor)).to be_a_new(Sponsor)
      end

      it "re-renders the 'new' template" do
	    log_in_as(@admin.account)
        post :create, {:sponsor => @invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      # let(:new_attributes) { {
    # :conference => Date.parse("2015-4-10"),
	# :sponsor_name => "Test",
	# :logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif")),
	# :priority => 5
	# }
      # }

      it "updates the requested sponsor" do
	    log_in_as(@admin.account)
        sponsor = Sponsor.create! valid_attributes
        put :update, {:id => sponsor.to_param, :sponsor => @new_attributes}, valid_session
        sponsor.reload
        expect(assigns(:sponsor)).to eq(sponsor)
      end

      it "assigns the requested sponsor as @sponsor" do
	    log_in_as(@admin.account)
        sponsor = Sponsor.create! valid_attributes
        put :update, {:id => sponsor.to_param, :sponsor => @valid_attributes2}, valid_session
        expect(assigns(:sponsor)).to eq(sponsor)
      end

      it "redirects to the sponsor" do
	    log_in_as(@admin.account)
        sponsor = Sponsor.create! valid_attributes
        put :update, {:id => sponsor.to_param, :sponsor => @valid_attributes2}, valid_session
        expect(response).to redirect_to(sponsor)
      end
	  
	  it "redirects update when not logged in" do
	    sponsor = Sponsor.create! valid_attributes
		put :update, {:id => sponsor.to_param, :sponsor => @valid_attributes2}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects update when not an admin" do
	    sponsor = Sponsor.create! valid_attributes
		log_in_as(@p.account)
		put :update, {:id => sponsor.to_param, :sponsor => @valid_attributes2}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns the sponsor as @sponsor" do
	    log_in_as(@admin.account)
        sponsor = Sponsor.create! valid_attributes
        put :update, {:id => sponsor.to_param, :sponsor => @invalid_attributes}, valid_session
        expect(assigns(:sponsor)).to eq(sponsor)
      end

      it "re-renders the 'edit' template" do
	    log_in_as(@admin.account)
        sponsor = Sponsor.create! valid_attributes
        put :update, {:id => sponsor.to_param, :sponsor => @invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested sponsor" do
	  log_in_as(@admin.account)
      sponsor = Sponsor.create! valid_attributes
      expect {
        delete :destroy, {:id => sponsor.to_param}, valid_session
      }.to change(Sponsor, :count).by(-1)
    end

    it "redirects to the sponsors list" do
	  log_in_as(@admin.account)
      sponsor = Sponsor.create! valid_attributes
      delete :destroy, {:id => sponsor.to_param}, valid_session
      expect(response).to redirect_to(sponsors_url)
    end
	
	it "redirects destroy when not logged in" do
	  sponsor = Sponsor.create! valid_attributes
	  delete :destroy, {:id => sponsor.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects destroy when not an admin" do
	  log_in_as(@p.account)
	  sponsor = Sponsor.create! valid_attributes
	  delete :destroy, {:id => sponsor.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end 
  end

end
