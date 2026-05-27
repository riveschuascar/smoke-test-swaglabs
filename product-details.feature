Feature: Product Detail Page

  As a Standard User
  I want to see detailed information about a product
  So that I can decide whether to buy it or not

  Background:
    Given I'm logged in as a Standard User

  Scenario: View the Backpack product details
    When I click on the "Sauce Labs Backpack" link
    Then I should be redirected to the product details page
    And the product title should be "Sauce Labs Backpack"
    And the product price should be "$29.99"
    And the "Add to cart" button should be visible

  Scenario: Return to the inventory page
    Given I'm on the "Sauce Labs Backpack" product page
    When I click on the "Back to products" link
    Then I should be redirected to the Products page