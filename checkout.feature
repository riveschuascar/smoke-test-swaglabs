Feature: Checkout

  As a Standard User
  I want to complete the checkout process
  So that I can buy products from SauceDemo

  Background:
    Given I have a product in the cart for checkout

  Scenario: Validate first name required field on checkout step one
    When I go to the checkout step one page
    And I continue checkout with empty information
    Then I should see the checkout first name required error message
      | expected_message              |
      | Error: First Name is required |

  @smoke
  Scenario: Cancel checkout from step one and return to cart
    When I go to the checkout step one page
    And I cancel checkout from step one
    Then I should be redirected to the cart page from checkout

  @smoke
  Scenario Outline: Complete checkout step two action
    When I go to the checkout step one page
    And I enter checkout information "<first_name>" "<last_name>" "<postal_code>"
    And I continue to the checkout overview page
    And I perform the checkout step two action "<action>"
    Then I should see the expected checkout step two result
      | expected_page   | expected_path   | expected_content   |
      | <expected_page> | <expected_path> | <expected_content> |

    Examples:
      | first_name | last_name | postal_code | action | expected_page | expected_path           | expected_content          |
      | Mauricio   | Garron    | 0000        | cancel | inventory     | /inventory.html         | Products                  |
      | Mauricio   | Garron    | 0000        | finish | complete      | /checkout-complete.html | Thank you for your order! |