Given('I am on the SauceDemo login page') do
  @login_page = CleanPOM::LoginPage.new
  @inventory_page = CleanPOM::InventoryPage.new
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
