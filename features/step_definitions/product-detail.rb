Given("I'm logged in as a Standard User") do
  visit('https://www.saucedemo.com/')
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'

  click_button 'login-button'
end

When("I click on the {string} link") do |string|
  case string
  when 'Sauce Labs Backpack'
    find('#item_4_title_link').click

  when 'Back to products'
    find('#back-to-products').click
  end
end

Then("I should be redirected to the product details page") do
  expect(page).to have_current_path(/inventory-item\.html\?id=4/)
end

Then("the product title should be {string}") do |title|
  product_title = find('.inventory_details_name').text

  expect(product_title).to eq(title)
end

Then("the product price should be {string}") do |price|
  product_price = find('.inventory_details_price').text

  expect(product_price).to eq(price)
end

Then("the {string} button should be visible") do |button_text|
  expect(page).to have_button(button_text)
end

Given("I'm on the {string} product page") do |product_page|
  step "I'm logged in as a Standard User"
  case product_page
  when 'Sauce Labs Backpack'
    find('#item_4_title_link').click
  end
end

Then("I should be redirected to the Products page") do
  expect(page).to have_current_path('/inventory.html', ignore_query: true)
  expect(page).to have_content('Products')
end