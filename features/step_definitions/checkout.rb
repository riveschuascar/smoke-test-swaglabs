CHECKOUT_USER = 'standard_user'
CHECKOUT_PASSWORD = 'secret_sauce'
CHECKOUT_PRODUCT_NAME = 'Sauce Labs Backpack'

def prepare_product_in_cart_for_checkout
  login_page = LoginPage.new
  inventory_page = InventoryPage.new
  cart_page = CartPage.new

  login_page.visit_page
  login_page.login_as(CHECKOUT_USER, CHECKOUT_PASSWORD)

  inventory_page.add_backpack_to_cart
  inventory_page.open_cart

  expect(page).to have_current_path('/cart.html', ignore_query: true)
  expect(page).to have_content(CHECKOUT_PRODUCT_NAME)
  expect(cart_page.displayed_with_product?(CHECKOUT_PRODUCT_NAME)).to be true
end

# ========== GIVEN ==========

Given('I have a product in the cart for checkout') do
  prepare_product_in_cart_for_checkout
end

# ========== WHEN - Checkout Step One ==========

When('I go to the checkout step one page') do
  @checkout_page = CheckoutPage.new
  @checkout_page.go_to_step_one

  expect(@checkout_page.on_step_one?).to be true
end

When('I continue checkout with empty information') do
  @checkout_page = CheckoutPage.new
  @checkout_page.continue
end

When('I cancel checkout from step one') do
  @checkout_page = CheckoutPage.new
  @checkout_page.cancel
end

When('I enter checkout information {string} {string} {string}') do |first_name, last_name, postal_code|
  @checkout_page = CheckoutPage.new
  @checkout_page.fill_information(first_name, last_name, postal_code)
end

# ========== WHEN - Checkout Step Two ==========

When('I continue to the checkout overview page') do
  @checkout_page = CheckoutPage.new
  @checkout_page.continue_to_overview

  expect(@checkout_page.overview_displayed?).to be true
end

When('I perform the checkout step two action {string}') do |action|
  @checkout_page = CheckoutPage.new

  case action
  when 'cancel'
    @checkout_page.cancel
  when 'finish'
    @checkout_page.finish
  else
    raise "Unsupported checkout step two action: #{action}"
  end
end

# ========== THEN - Error Validations ==========

Then('I should see the checkout first name required error message') do |table|
  @checkout_page = CheckoutPage.new
  expected_message = table.hashes.first.fetch('expected_message')

  expect(@checkout_page.error_message).to eq(expected_message)
end

# ========== THEN - Redirects & Results ==========

Then('I should be redirected to the cart page from checkout') do
  cart_page = CartPage.new

  expect(cart_page.displayed_with_product?(CHECKOUT_PRODUCT_NAME)).to be true
end

Then('I should see the expected checkout step two result') do |table|
  expected_result = table.hashes.first
  @checkout_page = CheckoutPage.new

  expect(
    @checkout_page.expected_result_displayed?(
      expected_result.fetch('expected_page'),
      expected_result.fetch('expected_path'),
      expected_result.fetch('expected_content')
    )
  ).to be true
end