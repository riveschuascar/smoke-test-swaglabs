USER = 'standard_user'
PASSWORD = 'secret_sauce'

Given('I am not logged in on SauceDemo') do
  Capybara.reset_sessions!
end

When('I visit the inventory page directly') do
  @inventory_page.visit_directly
end

Then('I should remain on the login page after direct inventory access') do
  expect(@login_page.displayed?).to be true
end

Then('I should see the inventory access denied message') do |table|
  expected_message = table.hashes.first.fetch('expected_message')
  expect(@login_page.error_message).to eq(expected_message)
end

Given('I am logged in on the SauceDemo inventory page') do
  @login_page.visit_page
  @login_page.login_as(USER, PASSWORD)
end

When('I sort inventory by {string}') do |sort_option|
  @inventory_page.sort_by(sort_option)
end

Then('the first inventory item should show {string} in the {string} field') do |expected_value, field|
  expect(@inventory_page.first_item_value(field)).to eq(expected_value)
end

Then('I should see the inventory product list') do |table|
  expected_products = table.hashes.map { |row| row.fetch('product') }
  expect(@inventory_page.product_names).to eq(expected_products)
end