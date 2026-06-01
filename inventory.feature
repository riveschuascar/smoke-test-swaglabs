@inventory
Feature: Inventory

  As a Standard User
  I want to access and organize the product inventory
  So that I can choose products to buy

  @smoke
  Scenario: Access inventory without login
    When I visit the inventory page directly
    Then I should remain on the login page after direct inventory access
    And I should see the inventory access denied message

  @smoke
  Scenario: Sort products by name from Z to A
    Given I am logged in on the SauceDemo inventory page
    When I sort inventory by "Name (Z to A)"
    Then the first inventory product should be "Test.allTheThings() T-Shirt (Red)"

  @smoke
  Scenario: Sort products by price from high to low
    Given I am logged in on the SauceDemo inventory page
    When I sort inventory by "Price (high to low)"
    Then the first inventory product price should be "$49.99"

  @smoke
  Scenario: Sort products by price from low to high
    Given I am logged in on the SauceDemo inventory page
    When I sort inventory by "Price (low to high)"
    Then the first inventory product price should be "$7.99"