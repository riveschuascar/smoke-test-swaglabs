@cart
Feature: Cart

  As a SauceDemo user
  I want to manage products in the shopping cart
  So that I can add, remove and continue with the purchase process

  Background:
    Given I am logged in with a clean cart

  @smoke
  Scenario Outline: Add product to cart from inventory page
    When I add "<product>" to the cart from the inventory page
    Then the cart badge should show "<quantity>"

    Examples:
      | product             | quantity |
      | Sauce Labs Backpack | 1        |

  @smoke
  Scenario Outline: Remove product from inventory page
    When I add "<product>" to the cart from the inventory page
    And I remove "<product>" from the inventory page
    Then the cart badge should not be visible

    Examples:
      | product             |
      | Sauce Labs Backpack |

  @smoke
  Scenario Outline: Add product to cart from product detail page
    When I open the detail page for "<product>"
    And I add "<product>" to the cart from the product detail page
    Then the cart badge should show "<quantity>"

    Examples:
      | product             | quantity |
      | Sauce Labs Backpack | 1        |

  @smoke
  Scenario Outline: Remove product from product detail page
    When I open the detail page for "<product>"
    And I add "<product>" to the cart from the product detail page
    And I remove "<product>" from the product detail page
    Then the cart badge should not be visible

    Examples:
      | product             |
      | Sauce Labs Backpack |

  @smoke
  Scenario Outline: Remove product from cart page
    When I add "<product>" to the cart from the inventory page
    And I open the cart page
    And I remove "<product>" from the cart page
    Then the cart item for "<product>" should not be visible

    Examples:
      | product             |
      | Sauce Labs Backpack |

  @smoke
  Scenario: Continue shopping from cart page
    When I open the cart page
    And I click the continue shopping button
    Then I should be redirected to the inventory page

  @smoke
  Scenario: Proceed to checkout from cart page
    When I add "Sauce Labs Backpack" to the cart from the inventory page
    And I open the cart page
    And I click the checkout button
    Then I should be redirected to the checkout information page