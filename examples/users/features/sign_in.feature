Feature: Sign in
  In order to increase registration counts
  A registered and signed in user
  Can access restricted features
  Which furthers the goal of Increasing Revenue

  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  As a user
  I want to sign in
  In order to access restricted features

    Scenario: User is not signed up
      Given I do not exist as a user
      When I sign in with valid credentials
      Then I see an invalid signin message
        And I should be signed out

    Scenario: User signs in successfully
      Given I exist as a user
        And I am not signed in
      When I sign in with valid credentials
      Then I see a successful sign in message
      When I return to the site
      Then I should be signed in

    Scenario: User enters wrong email
      Given I exist as a user
      And I am not signed in
      When I sign in with a wrong email
      Then I see an invalid signin message
      And I should be signed out
      
    Scenario: User enters wrong password
      Given I exist as a user
      And I am not signed in
      When I sign in with a wrong password
      Then I see an invalid signin message
      And I should be signed out

    Scenario: User is greeted upon signing in
      Given the user "Aslak" has an account
      And he is signed out
      When he signs in
      Then he should see "Welcome, Aslak"
