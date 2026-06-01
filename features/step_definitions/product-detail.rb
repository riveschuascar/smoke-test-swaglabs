Given("I am logged in as a Standard User") do
  visit('https://www.saucedemo.com/')
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'Login'
  expect(page).to have_current_path('https://www.saucedemo.com/inventory.html')
  expect(page).to have_css('.inventory_list')
end

When("I click on the {string} link") do |link_text|
  case link_text
  when 'Sauce Labs Backpack'
    find('#item_4_title_link').click
  when 'Back to products'
    find('#back-to-products').click
  end
end

Given("I am on the {string} product page") do |product_name|
  step %(I click on the "#{product_name}" link)
end

Then("the following product information should be displayed") do |table|
  data = table.rows_hash
  expect(page).to have_css('.inventory_details_name')
  expect(page).to have_css('.inventory_details_price')
  expect(find('.inventory_details_name').text).to eq(data['title'])
  expect(find('.inventory_details_price').text).to eq(data['price'])
end

Then('the button {string} is visible') do |button_text|
  expect(page).to have_button('add-to-cart')
end

Then("I am redirected to the Products page") do
  expect(page).to have_current_path('/inventory.html')
  expect(page).to have_content('Products')
end

Then("I can see the list of products") do
  expect(page).to have_css('.inventory_list')
  products = all('.inventory_item')
  expect(products.count).to eq(6)
end