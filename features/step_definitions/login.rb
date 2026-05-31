LOGIN_URL = 'https://www.saucedemo.com/'
INVENTORY_URL = 'https://www.saucedemo.com/inventory.html'

LOGIN_XPATH = {
  username_input: "//*[@data-test='username']",
  password_input: "//*[@data-test='password']",
  login_button: "//*[@data-test='login-button']"
}.freeze

LOGIN_CSS = {
  inventory_list: '.inventory_list',
  error_message: '[data-test="error"]'
}.freeze

def fill_login_field(field_xpath, value)
  find(:xpath, field_xpath, wait: 10).set(value)
end

def click_login_button
  find(:xpath, LOGIN_XPATH[:login_button], wait: 10).click
end

def login_error_message
  find(LOGIN_CSS[:error_message], wait: 10).text
end

Given('I am on the SauceDemo login page') do
  visit(LOGIN_URL)
end

When('I enter the username {string}') do |username|
  fill_login_field(LOGIN_XPATH[:username_input], username)
end

When('I enter the password {string}') do |password|
  fill_login_field(LOGIN_XPATH[:password_input], password)
end

When('I click the login button') do
  click_login_button
end

Then('I should be redirected to the inventory page') do
  expect(page).to have_current_path(INVENTORY_URL, ignore_query: true)
  expect(page).to have_css(LOGIN_CSS[:inventory_list], wait: 10)
end

Then('I should see the login error message {string}') do |expected_message|
  expect(login_error_message).to include(expected_message)
end

Then('I should see the required username error message') do
  expect(login_error_message).to include('Username is required')
end

Then('I should see the locked out user error message') do
  expect(login_error_message).to include('Sorry, this user has been locked out.')
end