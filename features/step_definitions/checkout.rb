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

Given('I am in the cart page') do
  @cart_page = CartPage.new
  expect(@cart_page.displayed_with_product?(CHECKOUT_PRODUCT_NAME)).to be true
end

# ========== WHEN ==========

When('I click {string} button') do |button|
  @checkout_page ||= CheckoutPage.new

  case button.downcase
  when 'checkout'
    @checkout_page.go_to_step_one
    expect(@checkout_page.on_step_one?).to be true
  when 'continue'
    @checkout_page.continue
  end
end

When('I click {string} button with empty information') do |_button|
  @checkout_page ||= CheckoutPage.new
  @checkout_page.continue
end

When('I enter checkout information {string} {string} {string}') do |first_name, last_name, postal_code|
  @checkout_page ||= CheckoutPage.new
  @checkout_page.fill_information(first_name, last_name, postal_code)
end

When('I {string} checkout from overview page') do |action|
  @checkout_page ||= CheckoutPage.new

  case action.downcase
  when 'cancel'
    @checkout_page.cancel
  when 'finish'
    @checkout_page.finish
  else
    raise "Unsupported checkout overview action: #{action}"
  end
end

# ========== THEN ==========

Then('I should see the {string} error message') do |expected_message, table|
  @checkout_page ||= CheckoutPage.new
  expected = table.hashes.first.fetch('expected_message', expected_message)

  expect(@checkout_page.error_message).to eq(expected)
end

Then('I should be redirected to the cart page from checkout') do
  expect(@cart_page.displayed_with_product?(CHECKOUT_PRODUCT_NAME)).to be true
end

Then('I see the message') do |table|
  @checkout_page ||= CheckoutPage.new
  expected = table.hashes.first

  expect(@checkout_page.on_complete?).to be true
  expect(@checkout_page.complete_header).to eq(expected.fetch('title'))
  expect(@checkout_page.complete_text).to eq(expected.fetch('text'))
end