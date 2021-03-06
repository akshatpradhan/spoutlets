require 'spec_helper'

feature "Users can like shared entries" do
  let(:user) {FactoryGirl.create(:user)}

  background { login user }

  context "with no user logged in" do
    scenario "been there button should invite user to sign in", js: true do
      FactoryGirl.create(:entry, user: FactoryGirl.create(:user))
      visit signout_path
      click_link "been there"
      page.should have_content "You need to sign in to like an entry."
    end
  end

  scenario "been there button should become un-been there", js: true do
    FactoryGirl.create(:entry, user: FactoryGirl.create(:user))
    visit entries_path
    click_link "been there"
    page.should have_link "un-been there"
    click_link "un-been there"
    page.should have_link "been there"
  end

  context "multiple entries" do
    let!(:entry) { FactoryGirl.create(:entry, user: FactoryGirl.create(:user)) }
    let!(:entry2) { FactoryGirl.create(:entry, user: FactoryGirl.create(:user)) }

    scenario "liking an entry should not affect others", js: true do
      visit entries_path
      page.find("#entry_like_#{entry.id} a").click
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
      click_link "un-been there"
      page.should have_content "5 others know the feeling."
    end
  end
end
