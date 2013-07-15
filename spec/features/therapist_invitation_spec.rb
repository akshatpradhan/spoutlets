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
    pending "figure out accept_invitation_path"
  end

  scenario "views entries of inviter" do
    pending "figure out cancan in ability.rb to enbale this"
  end
end