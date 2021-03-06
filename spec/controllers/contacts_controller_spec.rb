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

RSpec.describe ContactsController, type: :controller do

  before(:all){			
    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"}) 			
  }	
  after(:all){
	@admin.destroy
  }

  # This should return the minimal set of attributes required to create a valid
  # Contact. As you add validations to Contact, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
		:rank => 1,
		:group => "group1",
		:position => "position",
		:name => "name",
		:email => "email",
		:other => "other"
	}
  }

  let(:invalid_attributes) {
    {
		:rank => 1,
		:group => "",
		:position => "position",
		:name => "name",
		:email => "email",
		:other => "other"
	}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all contacts as @contacts" do
	  log_in_as(@admin.account)
      contact = Contact.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:contacts)).to include(contact)
    end
  end

  describe "GET #show" do
    it "assigns the requested contact as @contact" do
	  log_in_as(@admin.account)
      contact = Contact.create! valid_attributes
      get :show, {:id => contact.to_param}, valid_session
      expect(assigns(:contact)).to eq(contact)
    end
  end

  describe "GET #new" do
    it "assigns a new contact as @contact" do
	  log_in_as(@admin.account)
      get :new, {}, valid_session
      expect(assigns(:contact)).to be_a_new(Contact)
    end
  end

  describe "GET #edit" do
    it "assigns the requested contact as @contact" do
	  log_in_as(@admin.account)
      contact = Contact.create! valid_attributes
      get :edit, {:id => contact.to_param}, valid_session
      expect(assigns(:contact)).to eq(contact)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Contact" do
	    log_in_as(@admin.account)
        expect {
          post :create, {:contact => valid_attributes}, valid_session
        }.to change(Contact, :count).by(1)
      end

      it "assigns a newly created contact as @contact" do
	    log_in_as(@admin.account)
        post :create, {:contact => valid_attributes}, valid_session
        expect(assigns(:contact)).to be_a(Contact)
        expect(assigns(:contact)).to be_persisted
      end

      it "redirects to the created contact" do
	    log_in_as(@admin.account)
        post :create, {:contact => valid_attributes}, valid_session
        expect(response).to redirect_to(Contact.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved contact as @contact" do
	    log_in_as(@admin.account)
        post :create, {:contact => invalid_attributes}, valid_session
        expect(assigns(:contact)).to be_a_new(Contact)
      end

      it "re-renders the 'new' template" do
	    log_in_as(@admin.account)
        post :create, {:contact => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
		:rank => 5,
		:group => "group1",
		:position => "position",
		:name => "name",
		:email => "email",
		:other => "other"
	}
      }

      it "updates the requested contact" do
	    log_in_as(@admin.account)
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => new_attributes}, valid_session
        contact.reload
        expect(assigns(:contact)).to eq(contact)
      end

      it "assigns the requested contact as @contact" do
	    log_in_as(@admin.account)
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
        expect(assigns(:contact)).to eq(contact)
      end

      it "redirects to the contact" do
	    log_in_as(@admin.account)
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
        expect(response).to redirect_to(contact)
      end
    end

    context "with invalid params" do
      it "assigns the contact as @contact" do
	    log_in_as(@admin.account)
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => invalid_attributes}, valid_session
        expect(assigns(:contact)).to eq(contact)
      end

      it "re-renders the 'edit' template" do
	    log_in_as(@admin.account)
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested contact" do
	  log_in_as(@admin.account)
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, {:id => contact.to_param}, valid_session
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
	  log_in_as(@admin.account)
      contact = Contact.create! valid_attributes
      delete :destroy, {:id => contact.to_param}, valid_session
      expect(response).to redirect_to(contacts_url)
    end
  end

end
