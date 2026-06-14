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