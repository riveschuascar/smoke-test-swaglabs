@login
Feature: Login

  As a SauceDemo user
  I want to log in to the application
  So that I can access the inventory page

  @smoke
  Scenario Outline: Login fails with invalid data or user
    Given I am on the SauceDemo login page
    When I enter the username "<username>"
    And I enter the password "<password>"
    And I click the login button
    Then I should see the error message "<error_message>"

    Examples:
      | case            | username        | password     | error_message                             |
      | Empty form      |                 |              | Username is required                      |
      | Empty username  |                 | secret_sauce | Username is required                      |
      | Empty password  | standard_user   |              | Password is required                      |
      | Locked out user | locked_out_user | secret_sauce | Sorry, this user has been locked out.     |

  @smoke
  Scenario Outline: Successful login with valid credentials
    Given I am on the SauceDemo login page
    When I enter the username "<username>"
    And I enter the password "<password>"
    And I click the login button
    Then I should be redirected to the inventory page

    Examples:
      | case          | username      | password     |
      | Standard user | standard_user | secret_sauce |