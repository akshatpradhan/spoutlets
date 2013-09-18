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
  %w(happiness anxiety irritation).each do |emotional_state|
    scenario "#{emotional_state} bar should be visible when value is > 0" do
      FactoryGirl.create(:entry, user: user)
      visit entries_path
      page.should have_content(emotional_state)
      visit home_path
      page.should have_content(emotional_state)
      visit user_path(user)
      page.should have_content(emotional_state)
    end

    scenario "anxiety bar should not be visible when value is 0" do
      entry = FactoryGirl.create(:entry_without_emotional_state, user: user)
      visit entries_path
      page.should_not have_content(emotional_state)
      visit home_path
      page.should_not have_content(emotional_state)
      visit user_path(user)
      page.should_not have_content(emotional_state)
    end
  end
end
