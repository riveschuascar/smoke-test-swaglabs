Feature: Checkout

  As a Standard User
  I want to complete the checkout process
  So that I can buy products from SauceDemo

  Background:
    Given I have a product in the cart for checkout
    And I am in the cart page

  @smoke
  Scenario: Validate first name required field on 'Checkout: Your Information' page
    When I click "checkout" button
    And I click "continue" button with empty information
    Then I should see the "<expected_message>" error message
      | expected_message              |
      | Error: First Name is required |

  @smoke
  Scenario: Cancel an order from 'Checkout: Overview'
    When I click "checkout" button
    And I "cancel" checkout from overview page
    Then I should be redirected to the cart page from checkout

  @smoke
  Scenario Outline: Finish checkout to make an order
    When I click "checkout" button
    And I enter checkout information "Mauricio" "Garron" "0000"
    And I click "continue" button
    And I "finish" checkout from overview page
    Then I see the message
      | title                     | text                                                                                    |
      | Thank you for your order! | Your order has been dispatched, and will arrive just as fast as the pony can get there! |
