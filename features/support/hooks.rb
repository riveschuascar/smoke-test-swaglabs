After do
  Capybara.reset_sessions!
end

Before('@login') do
  @login_page = CleanPOM::LoginPage.new
  @inventory_page = CleanPOM::InventoryPage.new
end

Before('@logout') do
  @login_page = CleanPOM::LoginPage.new
  @inventory_page = CleanPOM::InventoryPage.new
  @burguer_menu = nil
end

Before('@cart') do
  @login_page = CleanPOM::LoginPage.new
  @inventory_page = InventoryPage.new
  @product_page = ProductDetailPage.new
  @cart_page = CartPage.new
end

Before('@details') do
  @login_page = LoginPage.new
  @inventory_page = InventoryPage.new
  @product_page = ProductDetailPage.new
end