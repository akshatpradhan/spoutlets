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
    visit new_therapist_invitation_path
    # NOTE => GET /therapists/invitation/new after signing in
    fill_in 'email', with: 'therapist@example.com'
    click_button 'Give secure access!'
    page.should have_content('An invitation email has been sent to therapist@example.com.')
    page.should have_content(/your journal/i)
    ActionMailer::Base.deliveries.last.to.should include("therapist@example.com")
    # NOTE => Fake send an email after clicking button
    # TODO Invitation email should be sent with inviter's last 5 journal entries.

  end
end

feature "Therapist wanting to access entries of inviter" do
  scenario "creates a new account" do
    therapist = Therapist.invite!(email: "therapist@example.com")
    therapist.accept_invitation!
    visit accept_therapist_invitation_path(invitation_token: therapist.invitation_token)
    # NOTE => GET /therapists/invitation/accept?invitation_token=uqASMfBxmfXvzSxg9q4b
    fill_in 'Name', with: 'Deana Finkel'
    fill_in 'Password', with: 'Password1'
    fill_in 'Password confirmation', with: 'Password1'
    click_button 'Create account!'
    page.should have_content(/Your password was set successfully. You are now signed in./i)
    page.should have_content(/Client Journals/i)
  end

  scenario "views entries of inviter" do
    pending "figure out cancan in ability.rb to enbale this"
  end
end