CHECKOUT_USER = 'standard_user'
CHECKOUT_PASSWORD = 'secret_sauce'
CHECKOUT_PRODUCT_NAME = 'Sauce Labs Backpack'

Before('@checkout') do
  begin
    Capybara.current_session.driver.quit
  rescue
  end

  Capybara.reset_sessions!
end

def login_as_standard_user
  visit('https://www.saucedemo.com/')

  fill_in 'user-name', with: CHECKOUT_USER
  fill_in 'password', with: CHECKOUT_PASSWORD
  click_button 'login-button'

  expect(page).to have_current_path('/inventory.html', ignore_query: true)
end

def add_backpack_to_cart
  find('#add-to-cart-sauce-labs-backpack').click
  find('.shopping_cart_link').click

  expect(page).to have_current_path('/cart.html', ignore_query: true)
  expect(page).to have_content(CHECKOUT_PRODUCT_NAME)
end

def go_to_checkout_step_one
  find('#checkout').click

  expect(page).to have_current_path('/checkout-step-one.html', ignore_query: true)
end

def fill_checkout_information(first_name, last_name, postal_code)
  fill_in 'first-name', with: first_name
  fill_in 'last-name', with: last_name
  fill_in 'postal-code', with: postal_code
end

Given('I have a product in the cart for checkout') do
  login_as_standard_user
  add_backpack_to_cart
end

When('I go to the checkout step one page') do
  go_to_checkout_step_one
end

When('I continue checkout with empty information') do
  find('#continue').click
end

Then('I should see the first name required error message') do
  expect(page).to have_css('[data-test="error"]')
  expect(page).to have_content('Error: First Name is required')
end

When('I cancel checkout from step one') do
  find('#cancel').click
end

Then('I should be redirected to the cart page from checkout') do
  expect(page).to have_current_path('/cart.html', ignore_query: true)
  expect(page).to have_content('Your Cart')
end

When('I enter checkout information {string} {string} {string}') do |first_name, last_name, postal_code|
  fill_checkout_information(first_name, last_name, postal_code)
end

When('I continue to the checkout overview page') do
  find('#continue').click

  expect(page).to have_current_path('/checkout-step-two.html', ignore_query: true)
  expect(page).to have_content('Checkout: Overview')
end

When('I perform the checkout step two action {string}') do |action|
  case action
  when 'cancel'
    find('#cancel').click

  when 'finish'
    find('#finish').click

  else
    raise "Unsupported checkout step two action: #{action}"
  end
end

Then('I should be redirected to {string} after checkout step two') do |expected_page|
  case expected_page
  when 'inventory'
    expect(page).to have_current_path('/inventory.html', ignore_query: true)
    expect(page).to have_content('Products')

  when 'complete'
    expect(page).to have_current_path('/checkout-complete.html', ignore_query: true)
    expect(page).to have_content('Thank you for your order!')

  else
    raise "Unsupported expected page: #{expected_page}"
  end
end