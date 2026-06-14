After do
  Capybara.reset_sessions!
end

Before('@cart') do
  @login_page = LoginPage.new
  @product_page = InventoryPage.new
  @cart_page = CartPage.new
end