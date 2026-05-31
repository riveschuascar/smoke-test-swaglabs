@cart
Feature: Cart

  As a SauceDemo user
  I want to manage products in the shopping cart
  So that I can add, remove and continue with the purchase process

  Background:
    Given I am logged in with a clean cart

  @smoke @inventory
  Scenario: Add product to cart from inventory page
    When I add the following product to the cart from the inventory page
      | product             |
      | Sauce Labs Backpack |
    Then the cart badge should show "1"

  @smoke @inventory
  Scenario: Remove product from inventory page
    When I add "Sauce Labs Backpack" to the cart from the inventory page
    And I remove "Sauce Labs Backpack" from the inventory page
    Then the cart badge should not be visible

  @smoke @product_detail
  Scenario: Add product to cart from product detail page
    When I open the detail page for "Sauce Labs Backpack"
    And I add "Sauce Labs Backpack" to the cart from the product detail page
    Then the cart badge should show "1"

  @smoke @product_detail
  Scenario: Remove product from product detail page
    When I open the detail page for "Sauce Labs Backpack"
    And I add "Sauce Labs Backpack" to the cart from the product detail page
    And I remove "Sauce Labs Backpack" from the product detail page
    Then the cart badge should not be visible

  @smoke @cart_page
  Scenario: Remove product from cart page
    When I add "Sauce Labs Backpack" to the cart from the inventory page
    And I open the cart page
    And I remove "Sauce Labs Backpack" from the cart page
    Then the cart item for "Sauce Labs Backpack" should not be visible

  @smoke @cart_page @navigation
  Scenario: Continue shopping from cart page
    When I open the cart page
    And I click the continue shopping button
    Then I should be redirected to the inventory page

  @smoke @cart_page @checkout
  Scenario: Proceed to checkout from cart page
    When I add the following product to the cart from the inventory page
      | product             |
      | Sauce Labs Backpack |
    And I open the cart page
    And I click the checkout button
    Then I should be redirected to the checkout information page