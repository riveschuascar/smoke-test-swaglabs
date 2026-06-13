require_relative '../../pages/login_page'
require_relative '../../pages/inventory_page'

After do
  Capybara.reset_sessions!
end

Before('@logout') do
  @login_page = LoginPage.new
  @inventory_page = InventoryPage.new
  @burguer_menu = nil
end