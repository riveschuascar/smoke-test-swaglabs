@smoke
Feature: Logout

  As a user
  I want to be able to log out from my account
  So that my information remains secure

  Scenario: Successful logout
    Given I navigate to the login page
    And I enter the credentials
      | user          | password     |
      | standard_user | secret_sauce |
    And I click the Login button
    And I verify that the Products page is displayed
    When I click the hamburger menu button
    And I click the Logout button
    Then I should be redirected to the login page
    And I should not have access to the Products page