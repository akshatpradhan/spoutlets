Feature: Logging in
  In order to increase registration counts
  A registered and logged in user
  Can access restricted features
  Which furthers the goal of Increasing Revenue

  As a user
  I want to log in
  In order to access restricted features

  Scenario: User is greeted upon logging in
    Given the user "Aslak" has an account
    And he is logged out
    When he logs in
    Then he should see "Welcome, Aslak"
