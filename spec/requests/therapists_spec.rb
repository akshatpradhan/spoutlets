require 'spec_helper'

describe "Therapists" do
  describe "GET /therapists" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get therapists_path
      response.status.should be(200)
    end
  end
end
