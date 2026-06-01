INVENTORY_USER = 'standard_user'
INVENTORY_PASSWORD = 'secret_sauce'
INVENTORY_URL = 'https://www.saucedemo.com/inventory.html'

Before('@inventory') do
  begin
    Capybara.current_session.driver.quit
  rescue
  end

  Capybara.reset_sessions!
end

def login_as_inventory_user
  visit('https://www.saucedemo.com/')

  fill_in 'user-name', with: INVENTORY_USER
  fill_in 'password', with: INVENTORY_PASSWORD
  click_button 'login-button'

  expect(page).to have_current_path('/inventory.html', ignore_query: true)
  expect(page).to have_css('.inventory_list')
end

def sort_inventory_by(sort_option)
  find('.product_sort_container').select(sort_option)
end

def first_inventory_item_name
  all('.inventory_item_name').first.text
end

def first_inventory_item_price
  all('.inventory_item_price').first.text
end

def first_inventory_item_value(field)
  case field
  when 'name'
    first_inventory_item_name

  when 'price'
    first_inventory_item_price

  else
    raise "Unsupported inventory field: #{field}"
  end
end

When('I visit the inventory page directly') do
  visit(INVENTORY_URL)
end

Then('I should remain on the login page after direct inventory access') do
  expect(page).to have_current_path('/', ignore_query: true)
end

Then('I should see the inventory access denied message') do
  expect(page).to have_css('[data-test="error"]')
  expect(page).to have_content('You can only access')
end

Given('I am logged in on the SauceDemo inventory page') do
  login_as_inventory_user
end

When('I sort inventory by {string}') do |sort_option|
  sort_inventory_by(sort_option)
end

Then('the first inventory item should show {string} in the {string} field') do |expected_value, field|
  expect(first_inventory_item_value(field)).to eq(expected_value)
end