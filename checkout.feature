@checkout
Feature: Checkout

  As a Standard User
  I want to complete the checkout process
  So that I can buy products from SauceDemo

  Background:
    Given I have a product in the cart for checkout

  @smoke
  Scenario: Checkout step one fails with empty form
    When I go to the checkout step one page
    And I continue checkout with empty information
    Then I should see the first name required error message

  @smoke
  Scenario: Cancel checkout step one and return to cart
    When I go to the checkout step one page
    And I cancel checkout from step one
    Then I should be redirected to the cart page from checkout

  @smoke
  Scenario: Cancel checkout step two and return to inventory
    When I go to the checkout step one page
    And I enter checkout information "Mauricio" "Garron" "0000"
    And I continue to the checkout overview page
    And I cancel checkout from step two
    Then I should be redirected to the inventory page from checkout

  @smoke
  Scenario: Finish checkout successfully
    When I go to the checkout step one page
    And I enter checkout information "Mauricio" "Garron" "0000"
    And I continue to the checkout overview page
    And I finish the checkout order
    Then I should see the checkout complete confirmation