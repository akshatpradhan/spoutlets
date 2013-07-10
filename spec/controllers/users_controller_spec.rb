require 'spec_helper'

describe UsersController do

  before do
    @user = FactoryGirl.create(:user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      'uid'  => '100004721472441',
      'provider' => 'facebook',
      'info' => {
        'name' => 'Bob Raymond',
      }
    }
  end

  describe "Get 'show' for non-logged in user" do
    it "redirects user to the root path to login" do
      session[:user_id] = nil
      get :show, id: @user.id
      response.should redirect_to(root_path)
    end
  end

  describe "Get 'show' for another user" do
    it "redirects user to root path with access denied" do
      @user2 = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      get :show, id: @user2
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'show' for logged in user" do
    it "returns http success" do
      session[:user_id] = @user.id
      get :show, id: @user
      response.should be_success
    end
  end

  describe "GET edit" do
    it "returns http success" do
      session[:user_id] = @user.id
      get :edit, id: @user
      response.should be_success
    end
  end

  describe "PUT update" do
    it "redirects user to @user" do
      session[:user_id] = @user.id
      put :update, id: @user, user: {name: "ted"}
      response.should redirect_to(@user)
    end
  end

  ################################################
  # As a User                                    #
  # I want to share my entries with my Therapist #
  # So that my Therapist can view my entries     #
  ################################################

  describe "creates new invitation" do
    it "What goes here" do
      session[:user_id] = @user.id
      visit '/therapists/invitation/new'
      page.should have_content('Keep your')
    end
  end

  # describe "GET new invitation" do
  #   it "assigns a new entry as @entry" do
  #     get :new, {}
  #     assigns(:invitation).should be_a_new(Invitation)
  #   end
  # end

  # Given I am on /users/:id
  # When I click Share with Therapist
  # Then I should see /therapists/invitation/new

  # Given I am on /therapists/invitation/new
  # When I fill in my Therapist email
  # Then I should see my entries

end
