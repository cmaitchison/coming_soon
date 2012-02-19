require "spec_helper"

describe WatchersController do
  describe "routing" do

    it "routes to #index" do
      get("/watchers").should route_to("watchers#index")
    end

    it "routes to #create" do
      post("/watchers").should route_to("watchers#create")
    end

  end
end
