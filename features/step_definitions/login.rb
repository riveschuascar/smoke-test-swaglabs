Given('I am on the SauceDemo login page') do
  visit('https://www.saucedemo.com/')
end

When('I enter the username {string}') do |username|
  fill_in 'user-name', with: username
end

When('I enter the password {string}') do |password|
  fill_in 'password', with: password
end

When('I click the login button') do
  click_button 'login-button'
end

Then('I should be redirected to the inventory page') do
  expect(page).to have_current_path('https://www.saucedemo.com/inventory.html', ignore_query: true)
  expect(page).to have_css('.inventory_list')
end