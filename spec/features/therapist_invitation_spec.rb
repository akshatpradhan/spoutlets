require 'spec_helper'

feature "User wanting to share entries with therapist" do

  let(:user) {FactoryGirl.create(:user)}

  background do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      'uid'  => '100004721472441',
      'provider' => 'facebook',
      'info' => {
        'name' => 'Bob Raymond',
      }
    }
    visit signin_path
  end

  scenario "invites a therapist" do
    # GET /therapists/invitation/new
    visit new_therapist_invitation_path
    fill_in 'email', with: 'therapist@example.com'
    click_button 'Enable Access!'
    page.should have_content('An invitation email has been sent to therapist@example.com.')
    page.should have_content(/your journal/i)
    # Invitation email should be sent with inviter's last 5 journal entries.
  end
end

feature "Therapist wanting to access entries of inviter" do
  scenario "creates a new account" do
    #1. Click invite link from above, it will look something like this /therapists/invitation/accept?invitation_token=uqASMfBxmfXvzSxg9q4b
    # How do I obtain that url and pass it to visit?
    fill_in 'name', with: 'Deana Finkel'
    fill_in 'password', with: 'Password1'
    fill_in 'password confirmation', with: 'Password1'
    click_button 'Create account!'
    page.should have_content(/Your password was set successfully. You are now signed in./i)
    page.should have_content(/Client Journals/i)
  end

  scenario "views entries of inviter" do
    pending "figure out cancan in ability.rb to enbale this"
  end
end
