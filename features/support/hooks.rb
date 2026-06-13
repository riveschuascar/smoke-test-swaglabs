After do
  Capybara.reset_sessions!
end

Before('@logout') do
  @login_page = CleanPOM::LoginPage.new
  @inventory_page = CleanPOM::InventoryPage.new
  @burguer_menu = nil
end