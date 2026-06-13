require_relative '../../pages/login_page'
require_relative '../../pages/inventory_page'

Given('I navigate to the login page') do
  @login_page.open
end

Given('I enter the credentials') do |table|
  data = table.hashes.first
  @login_page.login_form.fill_username(data['user'])
  @login_page.login_form.fill_password(data['password'])
end

Given('I click the Login button') do
  @login_page.login_form.click_login
end

Given('I verify that the Products page is displayed') do
  expect(@inventory_page.loaded?).to be true
end

When('I open the hamburger menu') do
  @burguer_menu = @inventory_page.open_burguer_menu
end

When('I click the Logout link') do
  @burguer_menu.find_by_text('Logout').click
end

Then('I should be redirected to the login page') do
  expect(@login_page.loaded?).to be true
end
