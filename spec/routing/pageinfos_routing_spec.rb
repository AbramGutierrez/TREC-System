require "rails_helper"

RSpec.describe PageinfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pageinfos").to route_to("pageinfos#index")
    end

    it "routes to #new" do
      expect(:get => "/pageinfos/new").to route_to("pageinfos#new")
    end

    it "routes to #show" do
      expect(:get => "/pageinfos/1").to route_to("pageinfos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pageinfos/1/edit").to route_to("pageinfos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pageinfos").to route_to("pageinfos#create")
    end

    it "routes to #update" do
      expect(:put => "/pageinfos/1").to route_to("pageinfos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pageinfos/1").to route_to("pageinfos#destroy", :id => "1")
    end

  end
end
