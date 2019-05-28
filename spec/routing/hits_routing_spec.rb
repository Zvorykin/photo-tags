require "rails_helper"

RSpec.describe HitsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/hits").to route_to("hits#index")
    end

    it "routes to #show" do
      expect(:get => "/hits/1").to route_to("hits#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/hits").to route_to("hits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hits/1").to route_to("hits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hits/1").to route_to("hits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hits/1").to route_to("hits#destroy", :id => "1")
    end
  end
end
