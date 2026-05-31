CART_URLS = {
  login: 'https://www.saucedemo.com/',
  inventory: 'https://www.saucedemo.com/inventory.html',
  checkout_information: 'https://www.saucedemo.com/checkout-step-one.html'
}.freeze

CART_USERS = {
  standard_user: 'standard_user',
  password: 'secret_sauce'
}.freeze

CART_PRODUCTS = {
  'Sauce Labs Backpack' => {
    inventory_add: "//*[@data-test='add-to-cart-sauce-labs-backpack']",
    inventory_remove: "//*[@data-test='remove-sauce-labs-backpack']",
    detail_add: "//*[@data-test='add-to-cart']",
    detail_remove: "//*[@data-test='remove']",
    cart_remove: "//*[@data-test='remove-sauce-labs-backpack']"
  }
}.freeze

CART_XPATH = {
  username_input: "//*[@data-test='username']",
  password_input: "//*[@data-test='password']",
  login_button: "//*[@data-test='login-button']",
  cart_link: "//a[contains(@class, 'shopping_cart_link')]",
  continue_shopping_button: "//*[@data-test='continue-shopping']",
  checkout_button: "//*[@data-test='checkout']"
}.freeze

CART_CSS = {
  inventory_list: '.inventory_list',
  cart_badge: '.shopping_cart_badge',
  cart_item: '.cart_item',
  checkout_info: '.checkout_info'
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

def find_by_xpath(xpath)
  find(:xpath, xpath, wait: 10)
end

def cart_product(product_name)
  CART_PRODUCTS.fetch(product_name)
end

def product_detail_link_xpath(product_name)
  "//div[contains(@class, 'inventory_item_name') and normalize-space()='#{product_name}']"
end

def login_with_clean_cart
  restart_cart_session

  visit(CART_URLS[:login])

  find_by_xpath(CART_XPATH[:username_input]).set(CART_USERS[:standard_user])
  find_by_xpath(CART_XPATH[:password_input]).set(CART_USERS[:password])
  find_by_xpath(CART_XPATH[:login_button]).click

  expect(page).to have_current_path(CART_URLS[:inventory], ignore_query: true)
  expect(page).to have_css(CART_CSS[:inventory_list], wait: 10)
end

Given('I am logged in with a clean cart') do
  login_with_clean_cart
end

When('I add {string} to the cart from the inventory page') do |product|
  find_by_xpath(cart_product(product)[:inventory_add]).click
end

When('I add the following product to the cart from the inventory page') do |table|
  table.hashes.each do |row|
    product = row.fetch('product')
    find_by_xpath(cart_product(product)[:inventory_add]).click
  end
end

When('I remove {string} from the inventory page') do |product|
  find_by_xpath(cart_product(product)[:inventory_remove]).click
end

When('I open the detail page for {string}') do |product|
  find_by_xpath(product_detail_link_xpath(product)).click
  expect(page).to have_current_path(/inventory-item.html/, wait: 10)
end

When('I add {string} to the cart from the product detail page') do |product|
  find_by_xpath(cart_product(product)[:detail_add]).click
end

When('I remove {string} from the product detail page') do |product|
  find_by_xpath(cart_product(product)[:detail_remove]).click
end

When('I open the cart page') do
  find_by_xpath(CART_XPATH[:cart_link]).click
end

When('I remove {string} from the cart page') do |product|
  find_by_xpath(cart_product(product)[:cart_remove]).click
end

When('I click the continue shopping button') do
  find_by_xpath(CART_XPATH[:continue_shopping_button]).click
end

When('I click the checkout button') do
  find_by_xpath(CART_XPATH[:checkout_button]).click
end

Then('the cart badge should show {string}') do |quantity|
  expect(page).to have_css(CART_CSS[:cart_badge], text: quantity, wait: 10)
end

Then('the cart badge should not be visible') do
  expect(page).to have_no_css(CART_CSS[:cart_badge], wait: 10)
end

Then('the cart item for {string} should not be visible') do |product|
  expect(page).to have_no_css(CART_CSS[:cart_item], text: product, wait: 10)
end

Then('I should be redirected to the checkout information page') do
  expect(page).to have_current_path(CART_URLS[:checkout_information], ignore_query: true)
  expect(page).to have_css(CART_CSS[:checkout_info], wait: 10)
end