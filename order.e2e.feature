@E2E
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
      And I go to the overview page
    Then The overview information should be
      | item_total | tax   | total  | card             | shippin                     |
      | $29.99     | $2.40 | $32.39 | SauceCard #31337 | Free Pony Express Delivery! |