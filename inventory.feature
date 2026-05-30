@inventory
Feature: Inventory

  As a Standard User
  I want to view and organize the product inventory
  So that I can choose products to buy

  Background:
    Given I am logged in on the SauceDemo inventory page

  @smoke
  Scenario: Inventory page displays the product list
    Then I should see the Products title
    And I should see at least 6 inventory items
    And each inventory item should show name, price and add to cart button

  @smoke
  Scenario: Sort products by name from A to Z
    When I sort inventory by "Name (A to Z)"
    Then the first inventory product should be "Sauce Labs Backpack"

  @smoke
  Scenario: Sort products by price from low to high
    When I sort inventory by "Price (low to high)"
    Then the first inventory product price should be "$7.99"