
Feature: Order E2E
    As a Standard User
    I want to make an order from the login page
    So I can purchase products with my account

    Scenario: Make an Order from Login to Logout
    Given I am on the SauceDemo login page
    Then I login with credentials
    | user          | password     |
    | standard_user | secret_sauce |
    And I click on the "Sauce Labs Backpack" link
    And I add "Sauce Labs Backpack" to the cart
    And I open the cart page
    And I go to the checkout step one page
    And I enter checkout information "Mauricio" "Garron" "0000"
    And I continue the checkout
    And I verify the checkout overview
    And I finish the checkout
    Then I see the confirmatio page
    And I am on login page after I logged out