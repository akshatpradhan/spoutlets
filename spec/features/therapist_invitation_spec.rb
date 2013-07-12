require 'spec_helper'
feature "User wanting to share his thoughts" do #feel free to name this differently ;-)

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
    visit new_therapist_invitation_path # GET /therapists/invitation/new
    page.should have_content('Keep your')
  end
end
