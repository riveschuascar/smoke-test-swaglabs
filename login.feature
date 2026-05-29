@login
Feature: Login

  As a SauceDemo user
  I want to log in to the application
  So that I can access the inventory page

  @smoke
  Scenario: Successful login with standard user
    Given I am on the SauceDemo login page
    When I enter the username "standard_user"
    And I enter the password "secret_sauce"
    And I click the login button
    Then I should be redirected to the inventory page