require "spec_helper"

describe AdminCommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin_comments").should route_to("admin_comments#index")
    end

    it "routes to #new" do
      get("/admin_comments/new").should route_to("admin_comments#new")
    end

    it "routes to #show" do
      get("/admin_comments/1").should route_to("admin_comments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin_comments/1/edit").should route_to("admin_comments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin_comments").should route_to("admin_comments#create")
    end

    it "routes to #update" do
      put("/admin_comments/1").should route_to("admin_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin_comments/1").should route_to("admin_comments#destroy", :id => "1")
    end

  end
end
