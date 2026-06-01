Feature: Logout

  As a user
  I want to be able to log out from my account
  So that my information remains secure

Scenario: Successful logout
  Given I am logged in as a standard user
  When I log out
  Then I should be redirected to the login page