require 'spec_helper'

describe "Watchers" do
  describe "GET /watchers" do
    it "requires authorization" do
      get watchers_path
      response.status.should == 401
    end
  end
end
