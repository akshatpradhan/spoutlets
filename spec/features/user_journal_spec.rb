require 'spec_helper'

feature "User wanting to view entries" do

  let(:user) {FactoryGirl.create(:user)}
  background { login user }

  scenario "needs to register an account" do
    #NOTE: since a user has already signed in in the background section, I need to sign him out
    visit signout_path
    visit signup_path
    click_button "Create your account"
    page.should have_content "You must provide a valid email address to register!"
    fill_in "user_email", with: "test@test.com"
    click_button "Create your account"
    page.should have_content "Welcome! You have signed up successfully."
    page.should have_content 'Shared entries'
    current_path.should == entries_path
    ActionMailer::Base.deliveries.last.to.should include("test@test.com")
  end

  scenario "must be signed in" do
    #NOTE: user has logged in in the background section of the feature
    page.should have_content "Signed in successfully."
    visit signout_path
    page.should have_content "Signed out successfully."
  end

  scenario "is offered to signup from the signin page" do
    visit signout_path
    visit signin_path
    page.should have_content "Don't have an account?"
    page.should have_link("Sign up")
  end

  scenario "is offered to signin from the signup page" do
    visit signout_path
    visit signup_path
    page.should have_content "Already have an account?"
    page.should have_link("Sign in")
  end

  %w(happiness anxiety irritation).each do |emotional_state|
    scenario "#{emotional_state} bar should be visible when value is > 0" do
      FactoryGirl.create(:entry, user: user)
      visit entries_path
      page.should have_content(emotional_state)
      visit root_path
      page.should have_content(emotional_state)
      visit user_path(user)
      page.should have_content(emotional_state)
    end

    scenario "anxiety bar should not be visible when value is 0" do
      entry = FactoryGirl.create(:entry_without_emotional_state, user: user)
      visit entries_path
      page.should_not have_content(emotional_state)
      visit root_path
      page.should_not have_content(emotional_state)
      visit user_path(user)
      page.should_not have_content(emotional_state)
    end
  end
end
