@smoke
Feature: Logout

  As a user
  I want to be able to log out from my account
  So that my information remains secure

@logout
Scenario: Successful logout
  Given I navigate to the login page
  And I login with credentials
  | user          | password     |
  | standard_user | secret_sauce |
  And I verify that the Products page is displayed
  When I open the hamburger menu
  And I click the Logout link
  Then I should be redirected to the login page
