require 'spec_helper'

describe User do
  describe ".fetch_categories" do
    before do
      @user = FactoryGirl.create(:user_with_entries, entries_count: 3)
    end
    it "should return an array of categories" do
      @user.fetch_categories.should == [["just feeling off", 3]]
    end
  end
end
