require 'spec_helper'

describe Therapist do
  describe "#invited_by" do
    let(:user) {FactoryGirl.create(:user)}

    before(:each) do
      Therapist.invite!({email: "psos@example.com"}, user)
    end
    it "should return the user who invited the therapist" do
      Therapist.last.invited_by.should == user
    end
  end
end
