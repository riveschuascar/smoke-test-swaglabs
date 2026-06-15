After do
  Capybara.reset_sessions!
end

Before('@E2E') do
  @login_page = LoginPage.new
  @products_page = ProductsPage.new
  @product_detail_page = ProductDetailPage.new
  @cart_page = CartPage.new
  @checkout_step_one_page = CheckoutStepOnePage.new
  @checkout_step_two_page = CheckoutStepTwoPage.new
  @checkout_complete_page = CheckoutCompletePage.new
  @menu_component = MenuComponent.new
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

Before('@inventory') do
  @login_page = LoginPage.new
  @inventory_page = InventoryPage.new
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