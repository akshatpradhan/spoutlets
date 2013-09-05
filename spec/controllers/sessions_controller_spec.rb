require 'spec_helper'

describe SessionsController do

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      'uid' => '100004721472441',
      'provider' => 'facebook',
      'info' => {
        'name' => 'Bob Raymond'
      }
    }
  end

  describe "GET 'new'" do
    it "redirects users to authentication" do
      get 'new'
      assert_redirected_to '/auth/facebook'
    end
  end

  describe "creates new user" do
    it "redirects new users with blank email to fill in their email" do
      user = FactoryGirl.create(:user, email: "")
      visit '/signin'
      page.should have_content "Logged in as Bob"
      page.should_not have_content "Signed in!"
      page.should have_content "Please enter your email address"
      current_path.should == edit_user_path(user)
    end
    it "redirects new users with email back to root_url" do
      FactoryGirl.create(:user)
      visit '/signin'
      page.should have_content "Signed in!"
      page.should have_content 'Shared entries'
      current_path.should == entries_path
    end
  end

end
