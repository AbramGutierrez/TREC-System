require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "GET #show_itinerary" do
    it "returns http success" do
      get :show_itinerary
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit_itinerary" do
    it "returns http success" do
      get :edit_itinerary
      expect(response).to have_http_status(:success)
    end
  end

end
