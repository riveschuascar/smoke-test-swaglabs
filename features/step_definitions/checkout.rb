Before('@checkout') do
  begin
    Capybara.current_session.driver.quit
  rescue
  end
  Capybara.reset_sessions!
end

Given('I have a product in the cart for checkout') do
  visit('https://www.saucedemo.com/')

  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'login-button'

  expect(page).to have_current_path('/inventory.html', ignore_query: true)

  find('#add-to-cart-sauce-labs-backpack').click
  find('.shopping_cart_link').click

  expect(page).to have_current_path('/cart.html', ignore_query: true)
  expect(page).to have_content('Sauce Labs Backpack')
end

When('I go to the checkout step one page') do
  find('#checkout').click
  expect(page).to have_current_path('/checkout-step-one.html', ignore_query: true)
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
  fill_in 'first-name', with: first_name
  fill_in 'last-name', with: last_name
  fill_in 'postal-code', with: postal_code
end

When('I continue to the checkout overview page') do
  find('#continue').click
  expect(page).to have_current_path('/checkout-step-two.html', ignore_query: true)
  expect(page).to have_content('Checkout: Overview')
end

When('I cancel checkout from step two') do
  find('#cancel').click
end

Then('I should be redirected to the inventory page from checkout') do
  expect(page).to have_current_path('/inventory.html', ignore_query: true)
  expect(page).to have_content('Products')
end

When('I finish the checkout order') do
  find('#finish').click
end

Then('I should see the checkout complete confirmation') do
  expect(page).to have_current_path('/checkout-complete.html', ignore_query: true)
  expect(page).to have_content('Thank you for your order!')
end