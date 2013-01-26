Feature: Creating and managing entries
  In order to increase registration counts
  A logged in user
  Can make a list of entries
  Which furthers the goal of Increasing Revenue

  As a logged in user
  I want to manage entries
  In order to have my own list of entries

  Scenario: My entries are listed on the home page
    Given I'm logged in

    And hoochie
    And I have entries titled Pizza, Breadsticks
    When I go to the home page
    Then I should see "Pizza"
    And I should see "Breadsticks"
