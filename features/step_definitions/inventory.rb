Given('I am logged in on the SauceDemo inventory page') do
  visit('https://www.saucedemo.com/')
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'login-button'

  expect(page).to have_current_path('/inventory.html', ignore_query: true)
  expect(page).to have_css('.inventory_list')
end

Then('I should see the Products title') do
  expect(page).to have_content('Products')
end

Then('I should see at least {int} inventory items') do |expected_quantity|
  items = all('.inventory_item', minimum: expected_quantity)
  expect(items.size).to be >= expected_quantity
end

Then('each inventory item should show name, price and add to cart button') do
  all('.inventory_item', minimum: 1).each do |item|
    expect(item).to have_css('.inventory_item_name')
    expect(item).to have_css('.inventory_item_price')
    expect(item).to have_css('button.btn_inventory')
  end
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