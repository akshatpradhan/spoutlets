Feature: Sign out
  In order to increase registration counts
  A signed out user
  Cannot access the restricted information of another user
  Which furthers the goal of Increasing Revenue

  As a user
  I want to sign out
  In order to protect myself from other users

  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given I am signed in
      When I sign out
      Then I should see a signed out message
      When I return to the site
      Then I should be signed out
      And I must be unable to access user features
