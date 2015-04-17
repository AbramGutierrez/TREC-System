require 'rails_helper'

RSpec.describe RegisterController, type: :controller do

  after(:each) {
	account = Account.last
	if account != nil
	  if account.user != nil
	    account.user.delete
	  end
	  account.delete
	end
  }

  let(:valid_attributes) { {
    :captain => false, 
	:shirt_size => "medium", 
	:phone => "1234567890",
	:first_name => "A", 
	:last_name => "Z", 
	:email => "registerControllerTest@example.com",
	:password => "mypassword", 
	:password_confirmation => "mypassword"
	}
  }
  
  let(:invalid_participant_attributes) {{
    :captain => false, 
	:shirt_size => "", 
	:phone => "1234567890",
	:first_name => "A", 
	:last_name => "Z", 
	:email => "registerControllerTest@example.com",
	:password => "mypassword", 
	:password_confirmation => "mypassword"
	}
  }
  
  let(:invalid_account_attributes) {{
    :captain => false, 
	:shirt_size => "medium", 
	:phone => "1234567890",
	:first_name => "A", 
	:last_name => "Z", 
	:email => "",
	:password => "mypassword", 
	:password_confirmation => "mypassword"
	}
  }  
  
  let(:valid_session) { {} }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      it "creates a new Participant" do
        expect {
          post :create, {:register => valid_attributes}, valid_session
        }.to change(Participant, :count).by(1)
      end
	  
	  it "creates a new Account" do
        expect {
          post :create, {:register => valid_attributes}, valid_session
        }.to change(Account, :count).by(1)
      end
	  
	  it "redirects to the home page" do
        post :create, {:register => valid_attributes}, valid_session
        expect(response).to redirect_to(root_url)
      end
	end
	
	context "with invalid params" do
      it "re-renders the 'new' template for invalid participant attributes" do
        post :create, {:register => invalid_participant_attributes}, valid_session
        expect(response).to render_template("new")
      end

      it "re-renders the 'new' template for invalid account attributes" do
        post :create, {:register => invalid_account_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end	

end
