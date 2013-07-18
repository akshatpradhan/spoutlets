require 'spec_helper'

feature "non-logged in user wanting to add an entry" do
  let(:user) {FactoryGirl.create(:user)}

  background do
    #### Faking Facebook pre-signin
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      'uid'  => user.id,
      'provider' => 'facebook',
      'info' => {
        'name' => user.name,
        'email' => user.email
      }
    }
    # for a possible refactoring of this
    # have a look at this : http://stackoverflow.com/questions/14013366/rspec-oauth-having-trouble-signing-in-from-within-a-test-omniauth-mock
    ####

    # this steps are in common with all scenarios in feature
    visit new_entry_path
    fill_in 'entry_content', with: 'jibberish'
    select 'other', from: 'entry_category'
    click_button 'Log it!'
  end

  scenario "created entries should be unapproved" do
    # some basic checks for the entry creation with approved field = false
    temp_entry = Entry.where(content: "jibberish").first
    temp_entry.should_not be_nil
    temp_entry.approved.should_not be_true
  end

  scenario "displays a preview of the created entry" do
    page.should have_content "Entry needs to be approved."
    page.should have_content "This is a preview of your entry."
    page.should have_content "jibberish"
    page.should have_content "other"
    page.should have_content "In order to log this entry you need to sign in."
    page.should have_content "You can abandon the entry submission by clicking the 'Cancel this entry' button"
    page.should have_link "Sign in with Facebook"
    page.should have_link "Cancel this entry"
  end

  scenario "entry can be approved and assigned to user after facebook signin" do
    # faking Facebook signin (this redirects to /auth/facebook and records the current path in the origin oauth parameters, see sessions_controller.rb for details)
    click_on "Sign in with Facebook"

    page.should have_content "Signed in!"
    page.should have_button "Approve this entry" # This button appears in the preview page if a user has logged in

    click_on "Approve this entry" # see app/view/entries/preview.html.erb for this button which is a hidden form updating the entry with approved = true
    page.should have_content "Entry was successfully updated"

    Entry.first.user_id.should_not be_nil # check if created entry has a user_id filled in
    Entry.first.approved.should be_true # check if created entry approved field has been set to true
  end

  scenario "entry is discarded" do
    pending "exercise for you, should be easy to implement ! see hints below"
    # current path is set in the background section -> preview entry
    # guest user cliks the cancel entry button
    # after the entry is destroyed the entries#destroy action redirects to the user_path(current_user) but current_user is nil... fix this with a conditional check
    # check if entry has been destroyed
  end
end
