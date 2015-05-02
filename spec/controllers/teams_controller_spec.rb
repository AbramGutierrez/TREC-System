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

RSpec.describe TeamsController, type: :controller do
 
  # This should return the minimal set of attributes required to create a valid
  # Team. As you add validations to Team, be sure to
  # adjust the attributes here as well.
  
  before(:all) {
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
	  
	@current = Conference.create!(start_date: Date.parse("2015-4-10"), 
			end_date: Date.parse("2015-4-12"),
			conf_start_date: Date.parse("2015-4-30"),
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
	  
	@team2 = Team.create!(:conference => @c,	
	  :school => "TestSchool",
	  :paid_status => "paid", 
	  :team_name => "ControllerTest2" 
	  )  
			
    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"}) 	
  }	
  before(:each){
	@p = Participant.create!(captain: true, shirt_size: "Large",
			phone: "1876543211", team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p4@example.com",
			password: "mypassword", password_confirmation: "mypassword"})
			
	@p2 = Participant.create!(captain: false, shirt_size: "Large",
			phone: "1876543211", team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p4_2@example.com",
			password: "mypassword", password_confirmation: "mypassword"})		
  }
  after(:each){
    @p2.destroy
    @p.destroy
  }
  after(:all){
	@c.destroy
	@current.destroy
	@team.destroy
	@team2.destroy
	@admin.account.destroy
	@admin.destroy
  }
	  
  let(:valid_attributes) { {
	:conference_id => @c.id,	
	:school => "TestSchool",
	:paid_status => "paid", 
	:team_name => "BestTeam"
	}
  }

  let(:invalid_attributes) { {
	:conference_id => @c.id,	
	:school => "",
	:paid_status => "paid", 
	:team_name => "BestTeam"
    } 
  }
  
  let(:current_new_attributes) { {
	    :conference_id => @current.id,	
		:school => "TestSchool2",
		:paid_status => "paid", 
		:team_name => "Losers"
	    }
      }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TeamsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all teams as @teams" do
	  log_in_as(@admin.account)
      team = Team.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:teams)).to include(team)
    end
	
	it "redirects index when account is not admin" do
      team = Team.create! valid_attributes
	  log_in_as(@p.account)
      get :index, {}, valid_session
	  expect(response).to redirect_to(root_url)
    end
	
	it "redirects index when not logged in" do
	  team = Team.create! valid_attributes
	  get :index, {}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
	end
  end

  describe "GET #show" do
    it "assigns the requested team as @team" do
      team = Team.create! valid_attributes
	  @p.team = team
	  @p.save!
	  log_in_as(@p.account)
      get :show, {:id => team.to_param}, valid_session
      expect(assigns(:team)).to eq(team)
    end
	
	it "does not redirect for an admin" do
	  team = Team.create! valid_attributes
	  log_in_as(@admin.account)
	  get :show, {:id => team.to_param}, valid_session
      expect(response).to_not redirect_to(root_url)
	end
	
	it "redirects show when not logged in" do
      team = Team.create! valid_attributes
      get :show, {:id => team.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects show when not on team" do
      team = Team.create! valid_attributes
	  @p.team = @team2
	  @p.save!
	  log_in_as(@p.account)
      get :show, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #new" do
    it "assigns a new team as @team" do
	  log_in_as(@p.account)
      get :new, {}, valid_session
      expect(assigns(:team)).to be_a_new(Team)
    end
	
	it "redirects new when not logged in" do
	  get :new, {}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects new when not a participant" do
	  log_in_as(@admin.account)
	  get :new, {}, valid_session
	  expect(response).to redirect_to(root_url)
	end
  end

  describe "GET #edit" do
    it "assigns the requested team as @team" do
      team = Team.create! valid_attributes
	  @p.team = team
	  @p.save!
	  log_in_as(@p.account)
      get :edit, {:id => team.to_param}, valid_session
      expect(assigns(:team)).to eq(team)
    end
	
	it "does not redirect edit for an admin" do
	  team = Team.create! valid_attributes
	  log_in_as(@admin.account)
	  get :edit, {:id => team.to_param}, valid_session
      expect(response).to_not redirect_to(root_url)
	end
	
	it "redirects edit when not logged in" do
      team = Team.create! valid_attributes
      get :edit, {:id => team.to_param}, valid_session
	  expect(flash).to_not be_nil
      expect(response).to redirect_to(login_url)
    end
	
	it "redirects edit when not on team" do
      team = Team.create! valid_attributes
	  @p.team = @team2
	  @p.save!
	  log_in_as(@p.account)
      get :edit, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(participant_dashboard_url)
    end
	
	it "redirects edit when not team captain" do
      team = Team.create! valid_attributes
	  @p2.team = team
	  @p2.save!
	  log_in_as(@p2.account)
      get :edit, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(participant_dashboard_url)
    end
	
	it "redirects edit when team captain but conference has started" do
	  team = Team.create! current_new_attributes
	  @p.team = team
	  @p.save!	
	  log_in_as(@p.account)
	  get :edit, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(participant_dashboard_url)
	end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Team" do
	    log_in_as(@p.account)
        expect {
          post :create, {:team => valid_attributes}, valid_session
        }.to change(Team, :count).by(1)
      end

      it "assigns a newly created team as @team" do
	    log_in_as(@p.account)
        post :create, {:team => valid_attributes}, valid_session
        expect(assigns(:team)).to be_a(Team)
        expect(assigns(:team)).to be_persisted
      end

      it "redirects to the created team" do
	    log_in_as(@p.account)
        post :create, {:team => valid_attributes}, valid_session
        expect(response).to redirect_to(Team.last)
      end
	  
	  it "redirects create when not logged in" do
	    post :create, {:team => valid_attributes}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects create when not a participant" do
	    log_in_as(@admin.account)
		post :create, {:team => valid_attributes}, valid_session
		expect(response).to redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved team as @team" do
	    log_in_as(@p.account)
        post :create, {:team => invalid_attributes}, valid_session
        expect(assigns(:team)).to be_a_new(Team)
      end

      it "re-renders the 'new' template" do
	    log_in_as(@p.account)
        post :create, {:team => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {
	    :conference_id => @c.id,	
		:school => "TestSchool2",
		:paid_status => "paid", 
		:team_name => "Losers"
	    }
      }

      it "updates the requested team" do
        team = Team.create! valid_attributes
		@p.team = team
		@p.save!
	    log_in_as(@p.account)
        put :update, {:id => team.to_param, :team => new_attributes}, valid_session
        team.reload
		expect(assigns(:team)).to eq(team)
      end

      it "assigns the requested team as @team" do
        team = Team.create! valid_attributes
		@p.team = team
		@p.save!
	    log_in_as(@p.account)
        put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        expect(assigns(:team)).to eq(team)
      end

      it "redirects to the team" do
        team = Team.create! valid_attributes
		@p.team = team
		@p.save!
	    log_in_as(@p.account)
        put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        expect(response).to redirect_to(team)
      end
	  
	  it "redirects update when not logged in" do
	    team = Team.create! valid_attributes
		put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
		expect(flash).to_not be_nil
		expect(response).to redirect_to(login_url)
	  end
	  
	  it "redirects update when not on team" do
	    team = Team.create! valid_attributes
		@p.team = @team2
		@p.save!
		log_in_as(@p.account)
		put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
		expect(response).to redirect_to(participant_dashboard_url)
	  end
	  
	  it "redirects update when not team captain" do
	    team = Team.create! valid_attributes
		@p2.team = team
		@p2.save!
		log_in_as(@p2.account)
		put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
		expect(response).to redirect_to(participant_dashboard_url)
	  end
	  
	  it "redirects update when team captain but conference has started" do
		team = Team.create! current_new_attributes
		@p.team = team
		@p.save!
		log_in_as(@p.account)		
		put :update, {:id => team.to_param, :team => current_new_attributes}, valid_session
		expect(response).to redirect_to(participant_dashboard_url)
	end
	  
	  it "does not redirect update for admin" do
	    team = Team.create! valid_attributes
		log_in_as(@admin.account)
		put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
		expect(response).to_not redirect_to(root_url)
	  end
    end

    context "with invalid params" do
      it "assigns the team as @team" do
        team = Team.create! valid_attributes
		@p.team = team
		@p.save!
	    log_in_as(@p.account)
        put :update, {:id => team.to_param, :team => invalid_attributes}, valid_session
        expect(assigns(:team)).to eq(team)
      end

      it "re-renders the 'edit' template" do
        team = Team.create! valid_attributes
		@p.team = team
		@p.save!
	    log_in_as(@p.account)
        put :update, {:id => team.to_param, :team => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested team" do
	  log_in_as(@admin.account)
      team = Team.create! valid_attributes
      expect {
        delete :destroy, {:id => team.to_param}, valid_session
      }.to change(Team, :count).by(-1)
    end

    it "redirects to the teams list" do
	  log_in_as(@admin.account)
      team = Team.create! valid_attributes
      delete :destroy, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(teams_url)
    end
	
	it "redirects destroy when not logged in" do
	  team = Team.create! valid_attributes
	  delete :destroy, {:id => team.to_param}, valid_session
	  expect(flash).to_not be_nil
	  expect(response).to redirect_to(login_url)
	end
	
	it "redirects destroy when not an admin" do
	  log_in_as(@p.account)
	  team = Team.create! valid_attributes
	  delete :destroy, {:id => team.to_param}, valid_session
	  expect(response).to redirect_to(root_url)
	end  
  end

end
