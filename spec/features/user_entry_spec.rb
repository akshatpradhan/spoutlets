require 'spec_helper'

feature "non-logged in user wanting to add an entry" do

  scenario "adds an entry" do
    visit new_entry_path
    fill_in 'entry_content', with: 'jibberish'
    select 'other', from: 'entry_category'
    click_button 'Log it!'
    #Page should redirect to /auth/facebook or signin_path and then after signing in, the entry should be saved
  end

end