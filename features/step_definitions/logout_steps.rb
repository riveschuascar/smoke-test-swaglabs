require_relative '../../pages/login_page'
require_relative '../../pages/inventory_page'

Given('I navigate to the login page') do
  @login_page.open
  @login_page.loaded?
end

Given('I login with credentials') do |table|
  data = table.hashes.first
  @login_page.login(data['user'], data['password'])
end

Given('I verify that the Products page is displayed') do
  expect(@inventory_page.loaded?).to be true
end

When('I open the hamburger menu') do
  @burguer_menu = @inventory_page.open_burger_menu
end

When('I click the Logout link') do
  @burguer_menu.find_by_text('Logout').click
end

Then('I should be redirected to the login page') do
  expect(@login_page.loaded?).to be true
end
