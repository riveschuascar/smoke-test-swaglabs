INVENTORY_USER = 'standard_user'
INVENTORY_PASSWORD = 'secret_sauce'

def login_as_inventory_user
  login_page = LoginPage.new
  inventory_page = InventoryPage.new

  login_page.visit_page
  login_page.login_as(INVENTORY_USER, INVENTORY_PASSWORD)

  expect(inventory_page.displayed?).to be true
end

Given('I am not logged in on SauceDemo') do
  Capybara.reset_sessions!
end

When('I visit the inventory page directly') do
  @inventory_page = InventoryPage.new
  @inventory_page.visit_directly
end

Then('I should remain on the login page after direct inventory access') do
  @login_page = LoginPage.new

  expect(@login_page.displayed?).to be true
end

Then('I should see the inventory access denied message') do |table|
  @login_page = LoginPage.new
  expected_message = table.hashes.first.fetch('expected_message')

  expect(@login_page.error_message).to eq(expected_message)
end

Given('I am logged in on the SauceDemo inventory page') do
  login_as_inventory_user
end

When('I sort inventory by {string}') do |sort_option|
  @inventory_page = InventoryPage.new
  @inventory_page.sort_by(sort_option)
end

Then('the first inventory item should show {string} in the {string} field') do |expected_value, field|
  @inventory_page = InventoryPage.new

  expect(@inventory_page.first_item_value(field)).to eq(expected_value)
end