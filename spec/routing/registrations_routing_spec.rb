require "rails_helper"

RSpec.describe RegistrationsController, type: :routing do
  describe "routing" do

    it "default to #new" do
      expect(:get => "/registrations").to route_to("registrations#new")
    end

    it "routes to #new" do
      expect(:get => "/registrations/new").to route_to("registrations#new")
    end

    it "routes to #create" do
      expect(:post => "/registrations").to route_to("registrations#create")
    end
	
	it "routes to #success" do
	  expect(:get => "/registrations/success").to route_to("registrations#success")
	end
	
	it "routes to #fail" do
	  expect(:get => "/registrations/fail").to route_to("registrations#fail")
	end
  end
end