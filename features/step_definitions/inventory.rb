Before do
  begin
    Capybara.current_session.driver.quit
  rescue
  end
  Capybara.reset_sessions!
end

When('I visit the inventory page directly') do
  visit('https://www.saucedemo.com/inventory.html')
end

Then('I should remain on the login page after direct inventory access') do
  expect(page).to have_current_path('/', ignore_query: true)
end

Then('I should see the inventory access denied message') do
  expect(page).to have_css('[data-test="error"]')
  expect(page).to have_content('You can only access')
end

Given('I am logged in on the SauceDemo inventory page') do
  visit('https://www.saucedemo.com/')
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'login-button'

  expect(page).to have_current_path('/inventory.html', ignore_query: true)
  expect(page).to have_css('.inventory_list')
end

When('I sort inventory by {string}') do |sort_option|
  find('.product_sort_container').select(sort_option)
end

Then('the first inventory product should be {string}') do |expected_product_name|
  first_product_name = all('.inventory_item_name').first.text
  expect(first_product_name).to eq(expected_product_name)
end

Then('the first inventory product price should be {string}') do |expected_price|
  first_product_price = all('.inventory_item_price').first.text
  expect(first_product_price).to eq(expected_price)
end