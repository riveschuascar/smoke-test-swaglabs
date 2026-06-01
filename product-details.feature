@smoke
Feature: Product Detail Page

  As a Standard User
  I want to see detailed information about a product
  So that I can decide whether to buy it or not

  Background:
    Given I am logged in as a Standard User

  Scenario: View the Backpack product details
    When I click on the "Sauce Labs Backpack" link
    Then the following product information should be displayed
      | title       | Sauce Labs Backpack |
      | price       | $29.99 |
      And the button "Add to cart" is visible

  Scenario: Return to the inventory page
    Given I am on the "Sauce Labs Backpack" product page
      And the following product information should be displayed
      | title       | Sauce Labs Backpack |
      | price       | $29.99 |
    When I click on the "Back to products" link
    Then I am redirected to the Products page
      And I can see the list of products