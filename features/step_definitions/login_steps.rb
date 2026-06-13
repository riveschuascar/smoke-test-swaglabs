require_relative '../../pages/login_page'
require_relative '../../pages/inventory_page'

Given('I am on the SauceDemo login page') do
  @login_page = LoginPage.new
  @inventory_page = InventoryPage.new
  @login_page.open
  @login_page.loaded?
end

When('I enter the username {string}') do |username|
  @login_page.login_form.fill_username(username)
end

When('I enter the password {string}') do |password|
  @login_page.login_form.fill_password(password)
end

When('I click the login button') do
  @login_page.login_form.click_login
end

Then('I should be redirected to the inventory page') do
  expect(@inventory_page.loaded?).to be true
end

Then('I should see the error message {string}') do |expected_message|
  expect(@login_page.login_form.error_message).to include(expected_message)
end

Then('I should see the required username error message') do
  expect(@login_page.login_form.error_message).to include('Username is required')
end

Then('I should see the locked out user error message') do
  expect(@login_page.login_form.error_message).to include('Sorry, this user has been locked out.')
end