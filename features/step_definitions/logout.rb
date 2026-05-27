Given('I am logged in as a standard user') do
  visit('https://www.saucedemo.com/')
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'

  click_button 'login-button'
end

When('I log out') do
  find('#react-burger-menu-btn').click
  find('#logout_sidebar_link').click
end

Then('I should be redirected to the login page') do
  expect(page).to have_current_path('https://www.saucedemo.com/', ignore_query: true)
end