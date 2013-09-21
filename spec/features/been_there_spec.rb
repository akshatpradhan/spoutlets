require 'spec_helper'

feature "Users can like shared entries" do
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

  context "when only the current user likes the entry" do
    let!(:entry) { FactoryGirl.create(:entry) }
    scenario "page should return 'you know the feeling'" do
      visit entries_path
      print page.html
      click_link "been there"
      page.should have_content "You know the feeling."
      click_link "been there"
      page.should have_content "Nobody knows the feeling."
    end
  end

  context "when the current user and others like the entry" do
    let!(:entry) { FactoryGirl.create(:entry, likes: 5) }
    scenario "page should return 'you know the feeling'" do
      visit entries_path
      print page.html
      click_link "been there"
      page.should have_content "You and 5 others know the feeling."
      click_link "been there"
      page.should have_content "5 others know the feeling."
    end
  end
end
