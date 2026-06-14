CHECKOUT_USER = 'standard_user'
CHECKOUT_PASSWORD = 'secret_sauce'
CHECKOUT_PRODUCT_NAME = 'Sauce Labs Backpack'

def prepare_product_in_cart_for_checkout
  login_page = LoginPage.new
  inventory_page = InventoryPage.new
  cart_page = CartPage.new

  login_page.visit_page
  login_page.login_as(CHECKOUT_USER, CHECKOUT_PASSWORD)

  expect(inventory_page.displayed?).to be true

  inventory_page.add_backpack_to_cart
  inventory_page.open_cart

  expect(cart_page.displayed_with_product?(CHECKOUT_PRODUCT_NAME)).to be true
end

Given('I have a product in the cart for checkout') do
  prepare_product_in_cart_for_checkout
end

When('I go to the checkout step one page') do
  cart_page = CartPage.new
  checkout_page = CheckoutPage.new

  cart_page.go_to_checkout

  expect(checkout_page.step_one_displayed?).to be true
end

When('I continue checkout with empty information') do
  checkout_page = CheckoutPage.new
  checkout_page.continue_with_empty_information
end

Then('I should see the first name required error message') do
  checkout_page = CheckoutPage.new

  expect(checkout_page.first_name_required_error_displayed?).to be true
end

When('I cancel checkout from step one') do
  checkout_page = CheckoutPage.new
  checkout_page.cancel_from_step_one
end

Then('I should be redirected to the cart page from checkout') do
  cart_page = CartPage.new

  expect(cart_page.displayed_with_product?(CHECKOUT_PRODUCT_NAME)).to be true
end

When('I enter checkout information {string} {string} {string}') do |first_name, last_name, postal_code|
  checkout_page = CheckoutPage.new
  checkout_page.fill_information(first_name, last_name, postal_code)
end

When('I continue to the checkout overview page') do
  checkout_page = CheckoutPage.new
  checkout_page.continue_to_overview

  expect(checkout_page.overview_displayed?).to be true
end

When('I perform the checkout step two action {string}') do |action|
  checkout_page = CheckoutPage.new
  checkout_page.perform_step_two_action(action)
end

Then('I should see the expected checkout step two result') do |table|
  expected_result = table.hashes.first
  checkout_page = CheckoutPage.new

  expect(
    checkout_page.expected_result_displayed?(
      expected_result.fetch('expected_page'),
      expected_result.fetch('expected_path'),
      expected_result.fetch('expected_content')
    )
  ).to be true
end