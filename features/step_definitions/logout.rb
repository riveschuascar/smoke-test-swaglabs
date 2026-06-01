Given('I navigate to the login page') do
  visit('https://www.saucedemo.com/')
end

Given('I enter the credentials') do |table|
  data = table.hashes.first
  fill_in 'user-name', with: data['user']
  fill_in 'password', with: data['password']
end

Given('I click the Login button') do
  click_button 'login-button'
end

Given('I verify that the Products page is displayed') do
  expect(page).to have_text('Products')

  inventory_items = all('.inventory_item')
  expect(inventory_items.count).to eq(6)
end

When('I click the hamburger menu button') do
  find('#react-burger-menu-btn').click
end

When('I click the Logout button') do
  find('#logout_sidebar_link').click
end

Then('I should be redirected to the login page') do
  expect(page).to have_current_path('https://www.saucedemo.com/')
  expect(page).to have_field('user-name')
  expect(page).to have_field('password')
end

Then('I should not have access to the Products page') do
  visit('https://www.saucedemo.com/inventory.html')
  expect(page).to have_current_path('https://www.saucedemo.com/')
  expect(page).to have_text("Epic sadface: You can only access '/inventory.html' when you are logged in.")
end