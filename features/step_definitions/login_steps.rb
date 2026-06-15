Given('I am on the SauceDemo login page') do
  @login_page.open
  @login_page.loaded?
end

When('I login with username {string} and password {string}') do |user, password|
  @login_page.login(user, password)
end

Then('I should be redirected to the inventory page') do
  binding.irb
  expect(@inventory_page.displayed?).to be true
end

Then('I should see the error message {string}') do |message|
  expect(@login_page).to be_error_displayed(message)
end
