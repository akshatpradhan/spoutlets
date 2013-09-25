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

  context "with no user logged in" do
    let!(:entry) { FactoryGirl.create(:entry, user: FactoryGirl.create(:user)) }
    scenario "been there button should redirect to sign in page", js: true do
      visit signout_path
      click_link "been there"
      page.should have_content "You need to sign in to like an entry."
    end
  end

  context "entry with no likes" do
    let!(:entry) { FactoryGirl.create(:entry, user: FactoryGirl.create(:user)) }
    scenario "page should return 'you know the feeling'", js: true do
      visit entries_path
      page.should have_content "Nobody knows the feeling."
      click_link "been there"
      page.should have_content "You know the feeling."
      click_link "been there"
      page.should have_content "Nobody knows the feeling."
    end
  end

  context "multiple entries" do
    let!(:entry) { FactoryGirl.create(:entry, user: FactoryGirl.create(:user)) }
    let!(:entry2) { FactoryGirl.create(:entry, user: FactoryGirl.create(:user)) }

    scenario "liking an entry should not affect others", js: true do
      visit entries_path
      page.find("#entry_like_#{entry.id}").click
      within("#entry_status_#{entry.id}") do
        page.should have_content "You know the feeling."
      end
      within("#entry_status_#{entry2.id}") do
        page.should_not have_content "You know the feeling."
      end
    end
  end

  context "entry with likes by others" do
    let!(:entry) { FactoryGirl.create(:entry, likes: 5) }
    scenario "page should return 'you and 5 others know the feeling'", js: true do
      visit entries_path
      page.should have_content "5 others know the feeling."
      click_link "been there"
      page.should have_content "You and 5 others know the feeling."
      click_link "been there"
      page.should have_content "5 others know the feeling."
    end
  end
end
