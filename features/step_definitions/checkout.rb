CHECKOUT_USER = 'standard_user'
CHECKOUT_PASSWORD = 'secret_sauce'
CHECKOUT_PRODUCT_NAME = 'Sauce Labs Backpack'

def login_as_standard_user
  login_page = LoginPage.new
  inventory_page = InventoryPage.new

  login_page.visit_page
  login_page.login_as(CHECKOUT_USER, CHECKOUT_PASSWORD)

  expect(inventory_page.displayed?).to be true
end

def add_backpack_to_cart
  find('#add-to-cart-sauce-labs-backpack').click
  find('.shopping_cart_link').click

  expect(page).to have_current_path('/cart.html', ignore_query: true)
  expect(page).to have_content(CHECKOUT_PRODUCT_NAME)
end

Given('I have a product in the cart for checkout') do
  login_as_standard_user
  add_backpack_to_cart
end

When('I go to the checkout step one page') do
  @checkout_page = CheckoutPage.new
  @checkout_page.go_to_step_one

  expect(@checkout_page.on_step_one?).to be true
end

When('I continue checkout with empty information') do
  @checkout_page = CheckoutPage.new
  @checkout_page.continue
end

Then('I should see the checkout first name required error message') do |table|
  @checkout_page = CheckoutPage.new
  expected_message = table.hashes.first.fetch('expected_message')

  expect(@checkout_page.error_message).to eq(expected_message)
end

When('I cancel checkout from step one') do
  @checkout_page = CheckoutPage.new
  @checkout_page.cancel
end

Then('I should be redirected to the cart page from checkout') do
  @checkout_page = CheckoutPage.new

  expect(@checkout_page.on_cart?).to be true
end

When('I enter checkout information {string} {string} {string}') do |first_name, last_name, postal_code|
  @checkout_page = CheckoutPage.new
  @checkout_page.fill_information(first_name, last_name, postal_code)
end

When('I continue to the checkout overview page') do
  @checkout_page = CheckoutPage.new
  @checkout_page.continue

  expect(@checkout_page.on_step_two?).to be true
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

Then('I should be redirected to {string} after checkout step two') do |expected_page|
  @checkout_page = CheckoutPage.new

  case expected_page
  when 'inventory'
    inventory_page = InventoryPage.new
    expect(inventory_page.displayed?).to be true
  when 'complete'
    expect(@checkout_page.on_complete?).to be true
  else
    raise "Unsupported expected page: #{expected_page}"
  end
end