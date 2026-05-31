def reset_product_detail_session
  begin
    Capybara.current_session.driver.quit
  rescue StandardError
    nil
  end

  begin
    Capybara.reset_sessions!
  rescue StandardError
    nil
  end
end

def login_as_standard_user_for_product_detail
  visit('https://www.saucedemo.com/')

  find('#user-name', wait: 10).set('standard_user')
  find('#password', wait: 10).set('secret_sauce')
  find('#login-button', wait: 10).click

  expect(page).to have_current_path('https://www.saucedemo.com/inventory.html', ignore_query: true)
  expect(page).to have_css('.inventory_list', wait: 10)
end

Given("I'm logged in as a Standard User") do
  reset_product_detail_session
  login_as_standard_user_for_product_detail
end

When("I click on the {string} link") do |link_text|
  case link_text
  when 'Sauce Labs Backpack'
    find('#item_4_title_link', wait: 10).click
  when 'Back to products'
    find('#back-to-products', wait: 10).click
  end
end

Then("I should be redirected to the product details page") do
  expect(page).to have_current_path(/inventory-item\.html\?id=4/)
end

Then("the product title should be {string}") do |title|
  product_title = find('.inventory_details_name', wait: 10).text
  expect(product_title).to eq(title)
end

Then("the product price should be {string}") do |price|
  product_price = find('.inventory_details_price', wait: 10).text
  expect(product_price).to eq(price)
end

Then("the {string} button should be visible") do |button_text|
  expect(page).to have_button(button_text, wait: 10)
end

Given("I'm on the {string} product page") do |product_page|
  reset_product_detail_session
  login_as_standard_user_for_product_detail

  case product_page
  when 'Sauce Labs Backpack'
    find('#item_4_title_link', wait: 10).click
  end

  expect(page).to have_current_path(/inventory-item\.html\?id=4/)
end

Then("I should be redirected to the Products page") do
  expect(page).to have_current_path('/inventory.html', ignore_query: true)
  expect(page).to have_content('Products')
end