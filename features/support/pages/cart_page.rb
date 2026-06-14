class CartPage
  include Capybara::DSL

  CART_PATH = '/cart.html'
  CART_TITLE = 'Your Cart'
  CHECKOUT_BUTTON_SELECTOR = '#checkout'

  def displayed?
    has_current_path?(CART_PATH, ignore_query: true) &&
      has_content?(CART_TITLE, wait: 10)
  end

  def displayed_with_product?(product_name)
    displayed? && has_content?(product_name, wait: 10)
  end

  def go_to_checkout
    find(CHECKOUT_BUTTON_SELECTOR, wait: 10).click
  end
end