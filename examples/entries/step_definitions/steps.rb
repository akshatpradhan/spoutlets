module LoginSteps
  def create_user(name)
    @user = User.create!(name: name)
  end

  def login_user(user)
    @user = user
    session[:user_id] = @user.id
  end

  def login_some_user
    create_user('Aslak')
# See spec/spec_helper.rb:
    login_user(@user)
  end
end

World(LoginSteps)

Given /hoochie/ do
  print 'hoochie'
end

Given /^I'm logged in$/ do
  login_some_user
end
  
Given /^the user "(.+)" has an account$/ do |name|
  create_user(name)
end

When /^he logs in$/ do
  login_user(@user)
end

# You can implement step definitions for undefined steps with these snippets:

Given /^I have entries titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Entry.create!(title: title)
  end
end

When /^I go to the home page$/ do
  visit('/')
end

Then /^(I|he) should see "(.*?)"$/ do |ignore, see|
  page.should have_content(see)
end

=begin
=end
