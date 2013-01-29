Given /^I have an entry titled (.+)$/ do |title|
  visit '/entries/new'
  fill_in 'Content', with: title
# Entry.create!(title: title)
  click_button 'Create Entry'
end

When /^I go to the home page$/ do
  visit('/')
end
