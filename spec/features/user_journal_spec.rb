require 'spec_helper'

feature "User wanting to view entries" do

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

  scenario "anxiety bar should be visible when value is > 0" do
    FactoryGirl.create(:entry, user: user)
    visit entries_path
    page.should have_content("anxiety")
    visit home_path
    page.should have_content("anxiety")
    visit user_path(user)
    page.should have_content("anxiety")
  end

  scenario "anxiety bar should not be visible when value is 0" do
    entry = FactoryGirl.create(:entry, anxiety_level: 0)
    visit entries_path
    page.should_not have_content("anxiety")
    visit home_path
    page.should_not have_content("anxiety")
    visit user_path(user)
    page.should_not have_content("anxiety")
  end
end
