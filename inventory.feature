Feature: Inventory

  As a Standard User
  I want to access and organize the product inventory
  So that I can choose products to buy

  @smoke
  Scenario: Validate direct inventory access without login
    When I visit the inventory page directly
    Then I should remain on the login page after direct inventory access
    And I should see the inventory access denied message

  @smoke
  Scenario Outline: Sort inventory products
    Given I am logged in on the SauceDemo inventory page
    When I sort inventory by "<sort_option>"
    Then the first inventory item should show "<expected_value>" in the "<field>" field

    Examples:
      | sort_option         | field | expected_value                    |
      | Name (Z to A)       | name  | Test.allTheThings() T-Shirt (Red) |
      | Price (high to low) | price | $49.99                            |
      | Price (low to high) | price | $7.99                             |