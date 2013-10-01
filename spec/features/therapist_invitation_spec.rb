require 'spec_helper'

feature "User sends an invitation to his therapist" do

  let(:user) {FactoryGirl.create(:user_with_entries, entries_count: 10)}
  let(:therapist_email) {"therapist@example.com"}

  background do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = {
      uid: '100004721472441',
      provider: 'linkedin',
      info: {
        name: 'Sigmund Freud',
        email: therapist_email
      }
    }
    login user
    visit new_therapist_invitation_path
    fill_in 'therapist_email', with: therapist_email
    click_button 'Give secure access!'
  end

  scenario "therapist receives a mail with his client last 5 journal entries" do
    therapist = Therapist.where(email: therapist_email).first
    page.should have_content('An invitation email has been sent to therapist@example.com.')
    page.should have_content(/your entries/i)
    mail = ActionMailer::Base.deliveries.last
    mail.to.should include therapist.email
    (1..5).each do |n|
      mail.body.encoded.should match(/entry_content_#{n}/)
    end
  end

  scenario "therapist accepts invitation and views his client journals" do
    therapist = Therapist.where(email: therapist_email).first
    visit accept_therapist_invitation_path(invitation_token: therapist.invitation_token)
    click_link "logout" #NOTE: testing signout and re signin with linkedin
    page.should have_content(/signed out/i)
    click_link "for therapists"
    page.should have_content /Successfully authenticated from Linkedin account/i
    page.should have_content(/Client Journals/i)
    #TODO: add cancan ability statements for therapist
  end
end
