require "spec_helper"

describe TherapistsController do
  describe "routing" do

    it "routes to #index" do
      get("/therapists").should route_to("therapists#index")
    end

    it "routes to #new" do
      get("/therapists/new").should route_to("therapists#new")
    end

    it "routes to #show" do
      get("/therapists/1").should route_to("therapists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/therapists/1/edit").should route_to("therapists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/therapists").should route_to("therapists#create")
    end

    it "routes to #update" do
      put("/therapists/1").should route_to("therapists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/therapists/1").should route_to("therapists#destroy", :id => "1")
    end

  end
end
