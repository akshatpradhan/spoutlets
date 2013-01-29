Feature: Sign up
  In order to increase sign up counts
  An unsigned up user
  Cannot access restricted features
  Which furthers the goal of Increasing Revenue

  As a user
  I want to sign up
  And I want to sign in
  In order to access restricted features

  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not signed in

    Scenario: User signs up with valid data
      When I sign up with valid user data
# TODO: Test authentication by Facebook
#     Then I should see a successful sign up message
      
    Scenario: User signs up with invalid email
      When I sign up with an invalid email
# TODO: Test authentication by Facebook
#     Then I should see an invalid email message

    Scenario: User signs up without password
      When I sign up without a password
# TODO: Test authentication by Facebook
#     Then I should see a missing password message

    Scenario: User signs up without password confirmation
      When I sign up without a password confirmation
# TODO: Test authentication by Facebook
#     Then I should see a missing password confirmation message

    Scenario: User signs up with mismatched password and confirmation
      When I sign up with a mismatched password confirmation
# TODO: Test authentication by Facebook
#     Then I should see a mismatched password message
