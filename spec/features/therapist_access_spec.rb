require 'spec_helper'

feature "Therapist wanting to have access to spoutlets" do
  scenario "creates a new account through a client invitation" do
    therapist = Therapist.invite!(email: "therapist@example.com")
    therapist.accept_invitation!
    visit accept_therapist_invitation_path(invitation_token: therapist.invitation_token)
    # NOTE => GET /therapists/invitation/accept?invitation_token=uqASMfBxmfXvzSxg9q4b
    fill_in 'therapist_name', with: 'Deana Finkel'
    click_button "View your client's journal!"
    page.should have_content(/You are now signed in./i)
    page.should have_content(/Client Journals/i)
  end

  scenario "logs in/out if registered" do
    pending "this after"
  end

  scenario "views entries of inviter" do
    pending "this as third scenario"
  end
end
