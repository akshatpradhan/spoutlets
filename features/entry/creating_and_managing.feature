Feature: Creating and managing entries
  In order to increase registration counts
  A signed in user
  Can make a list of entries
  Which furthers the goal of Increasing Revenue

  As a signed in user
  I want to manage entries
  In order to have my own list of entries

  Scenario: My entries are listed on the home page
    Given I am signed in
#   And I have entries titled Pizza, Breadsticks
#   And I have an entry titled Logout
    And I have an entry titled Pizza
    And I have an entry titled Breadsticks
    When I go to the home page
#   Then I should see 'Logout'
    Then I should see 'Pizza'
    And I should see 'Breadsticks'
