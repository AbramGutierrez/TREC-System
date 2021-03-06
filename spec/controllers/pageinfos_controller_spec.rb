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

RSpec.describe PageinfosController, type: :controller do

  before(:all){			
    @admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "admin", password_confirmation: "admin"}) 			
  }	
  after(:all){
	@admin.destroy
  }

  # This should return the minimal set of attributes required to create a valid
  # Pageinfo. As you add validations to Pageinfo, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
		:page => "page",
		:body => "textext"
	}
  }

  let(:invalid_attributes) {
    
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PageinfosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all pageinfos as @pageinfos" do
	  log_in_as(@admin.account)
      pageinfo = Pageinfo.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:pageinfos)).to eq([pageinfo])
    end
  end

  describe "GET #show" do
    it "assigns the requested pageinfo as @pageinfo" do
	  log_in_as(@admin.account)
      pageinfo = Pageinfo.create! valid_attributes
      get :show, {:id => pageinfo.to_param}, valid_session
      expect(assigns(:pageinfo)).to eq(pageinfo)
    end
  end

  describe "GET #new" do
    it "assigns a new pageinfo as @pageinfo" do
	  log_in_as(@admin.account)
      get :new, {}, valid_session
      expect(assigns(:pageinfo)).to be_a_new(Pageinfo)
    end
  end

  describe "GET #edit" do
    it "assigns the requested pageinfo as @pageinfo" do
	  log_in_as(@admin.account)
      pageinfo = Pageinfo.create! valid_attributes
      get :edit, {:id => pageinfo.to_param}, valid_session
      expect(assigns(:pageinfo)).to eq(pageinfo)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Pageinfo" do
	    log_in_as(@admin.account)
        expect {
          post :create, {:pageinfo => valid_attributes}, valid_session
        }.to change(Pageinfo, :count).by(1)
      end

      it "assigns a newly created pageinfo as @pageinfo" do
	    log_in_as(@admin.account)
        post :create, {:pageinfo => valid_attributes}, valid_session
        expect(assigns(:pageinfo)).to be_a(Pageinfo)
        expect(assigns(:pageinfo)).to be_persisted
      end

      it "redirects to the created pageinfo" do
	    log_in_as(@admin.account)
        post :create, {:pageinfo => valid_attributes}, valid_session
        expect(response).to redirect_to(Pageinfo.last)
      end
    end

    # context "with invalid params" do
      # it "assigns a newly created but unsaved pageinfo as @pageinfo" do
        # post :create, {:pageinfo => invalid_attributes}, valid_session
        # expect(assigns(:pageinfo)).to be_a_new(Pageinfo)
      # end

      # it "re-renders the 'new' template" do
        # post :create, {:pageinfo => invalid_attributes}, valid_session
        # expect(response).to render_template("new")
      # end
    # end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
		:page => "page",
		:body => "textext"
	}
      }

      it "updates the requested pageinfo" do
	    log_in_as(@admin.account)
        pageinfo = Pageinfo.create! valid_attributes
        put :update, {:id => pageinfo.to_param, :pageinfo => new_attributes}, valid_session
        pageinfo.reload
        expect(assigns(:pageinfo)).to eq(pageinfo)
      end

      it "assigns the requested pageinfo as @pageinfo" do
	    log_in_as(@admin.account)
        pageinfo = Pageinfo.create! valid_attributes
        put :update, {:id => pageinfo.to_param, :pageinfo => valid_attributes}, valid_session
        expect(assigns(:pageinfo)).to eq(pageinfo)
      end

      it "redirects to the pageinfo" do
	    log_in_as(@admin.account)
        pageinfo = Pageinfo.create! valid_attributes
        put :update, {:id => pageinfo.to_param, :pageinfo => valid_attributes}, valid_session
        expect(response).to redirect_to(pageinfo)
      end
    end

    # context "with invalid params" do
      # it "assigns the pageinfo as @pageinfo" do
        # pageinfo = Pageinfo.create! valid_attributes
        # put :update, {:id => pageinfo.to_param, :pageinfo => invalid_attributes}, valid_session
        # expect(assigns(:pageinfo)).to eq(pageinfo)
      # end

      # it "re-renders the 'edit' template" do
        # pageinfo = Pageinfo.create! valid_attributes
        # put :update, {:id => pageinfo.to_param, :pageinfo => invalid_attributes}, valid_session
        # expect(response).to render_template("edit")
      # end
    # end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pageinfo" do
	  log_in_as(@admin.account)
      pageinfo = Pageinfo.create! valid_attributes
      expect {
        delete :destroy, {:id => pageinfo.to_param}, valid_session
      }.to change(Pageinfo, :count).by(-1)
    end

    it "redirects to the pageinfos list" do
	  log_in_as(@admin.account)
      pageinfo = Pageinfo.create! valid_attributes
      delete :destroy, {:id => pageinfo.to_param}, valid_session
      expect(response).to redirect_to(pageinfos_url)
    end
  end

end
