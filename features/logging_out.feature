Feature: Logging out
  In order to increase registration counts
  A logged out user
  Cannot access the restricted information of another user
  Which furthers the goal of Increasing Revenue

  As a user
  I want to log out
  In order to protect myself from other users

  Scenario: User is informed he has just now been logged out successfully
    Given I'm logged in
    When I log out
    Then I must see "You have been logged out"
    And I must be unable to access user features

