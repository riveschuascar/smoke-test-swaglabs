@E2E
Feature: Order E2E
  As a Standard User
  I want to make an order from the login page
  So I can purchase products with my account

  @smoke
  Scenario: Make an Order starting in Login Page
    Given I am on the SauceDemo login page
    When I login with credentials
      | user          | password     |
      | standard_user | secret_sauce |
      And I click on the "Sauce Labs Backpack" link
      And I add "Sauce Labs Backpack" to the cart
      And I open the cart page
      And I click "checkout" button
      And I enter checkout information "Mauricio" "Garron" "0000"
      And I click "continue" button
    Then The overview information should be
      | item_total | tax   | total  | card             | shippin                     |
      | $29.99     | $2.40 | $32.39 | SauceCard #31337 | Free Pony Express Delivery! |
