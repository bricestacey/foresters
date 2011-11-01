require "spec_helper"

describe CourtsController do
  describe "routing" do

    it "routes to #index" do
      get("/courts").should route_to("courts#index")
    end

    it "routes to #new" do
      get("/courts/new").should route_to("courts#new")
    end

    it "routes to #show" do
      get("/courts/1").should route_to("courts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/courts/1/edit").should route_to("courts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/courts").should route_to("courts#create")
    end

    it "routes to #update" do
      put("/courts/1").should route_to("courts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/courts/1").should route_to("courts#destroy", :id => "1")
    end

  end
end
