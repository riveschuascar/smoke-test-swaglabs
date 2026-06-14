After do
  Capybara.reset_sessions!
end

Before('@cart') do
  @login_page = LoginPage.new
  @product_page = InventoryPage.new
  @cart_page = CartPage.new
end

Before('@details') do
  @login_page = LoginPage.new
  @inventory_page = InventoryPage.new
  @product_page = ProductDetailPage.new
end