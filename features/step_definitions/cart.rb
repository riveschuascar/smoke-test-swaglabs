PRODUCTS = {
  'Sauce Labs Backpack' => {
    inventory_add: "//*[@data-test='add-to-cart-sauce-labs-backpack']",
    inventory_remove: "//*[@data-test='remove-sauce-labs-backpack']",
    detail_add: "//*[@data-test='add-to-cart']",
    detail_remove: "//*[@data-test='remove']",
    cart_remove: "//*[@data-test='remove-sauce-labs-backpack']"
  }
}.freeze

def restart_cart_session
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

Given('I am logged in with a clean cart') do
  restart_cart_session

  visit('https://www.saucedemo.com/')

  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'login-button'

  expect(page).to have_current_path('https://www.saucedemo.com/inventory.html', ignore_query: true)
  expect(page).to have_xpath("//div[contains(@class, 'inventory_list')]", wait: 10)
end

When('I add {string} to the cart from the inventory page') do |product|
  find(:xpath, PRODUCTS.fetch(product)[:inventory_add], wait: 10).click
end

When('I remove {string} from the inventory page') do |product|
  find(:xpath, PRODUCTS.fetch(product)[:inventory_remove], wait: 10).click
end

When('I open the detail page for {string}') do |product|
  product_link_xpath = "//div[contains(@class, 'inventory_item_name') and normalize-space()='#{product}']"
  find(:xpath, product_link_xpath, wait: 10).click
  expect(page).to have_current_path(/inventory-item.html/, wait: 10)
end

When('I add {string} to the cart from the product detail page') do |product|
  find(:xpath, PRODUCTS.fetch(product)[:detail_add], wait: 10).click
end

When('I remove {string} from the product detail page') do |product|
  find(:xpath, PRODUCTS.fetch(product)[:detail_remove], wait: 10).click
end

When('I open the cart page') do
  find(:xpath, "//a[contains(@class, 'shopping_cart_link')]", wait: 10).click
end

When('I remove {string} from the cart page') do |product|
  find(:xpath, PRODUCTS.fetch(product)[:cart_remove], wait: 10).click
end

When('I click the continue shopping button') do
  find(:xpath, "//*[@data-test='continue-shopping']", wait: 10).click
end

When('I click the checkout button') do
  find(:xpath, "//*[@data-test='checkout']", wait: 10).click
end

Then('the cart badge should show {string}') do |quantity|
  badge_xpath = "//span[contains(@class, 'shopping_cart_badge') and normalize-space()='#{quantity}']"
  expect(page).to have_xpath(badge_xpath, wait: 10)
end

Then('the cart badge should not be visible') do
  expect(page).to have_no_xpath("//span[contains(@class, 'shopping_cart_badge')]", wait: 10)
end

Then('the cart item for {string} should not be visible') do |product|
  cart_item_xpath = "//div[contains(@class, 'cart_item')][.//*[normalize-space()='#{product}']]"
  expect(page).to have_no_xpath(cart_item_xpath, wait: 10)
end

Then('I should be redirected to the checkout information page') do
  expect(page).to have_current_path('https://www.saucedemo.com/checkout-step-one.html', ignore_query: true)
  expect(page).to have_xpath("//div[contains(@class, 'checkout_info')]", wait: 10)
end