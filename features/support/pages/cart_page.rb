class CartPage
  include Capybara::DSL

  CART_PATH    = '/cart.html'
  CART_TITLE   = 'Your Cart'
  CART_ITEM_SELECTOR = '.cart_item'

  XPATH = {
    continue_shopping: "//*[@data-test='continue-shopping']",
    checkout:          "//*[@data-test='checkout']",
    cart_link:         "//a[contains(@class, 'shopping_cart_link')]"
  }.freeze

  CSS = {
    cart_badge: '.shopping_cart_badge',
    cart_item:  '.cart_item'
  }.freeze

  CHECKOUT_URL = 'https://www.saucedemo.com/checkout-step-one.html'
  CHECKOUT_INFO_SELECTOR = '.checkout_info'

  # ─── Navigation ────────────────────────────────────────────────────────────

  def open
    find(:xpath, XPATH[:cart_link], wait: 10).click
  end

  def continue_shopping
    find(:xpath, XPATH[:continue_shopping], wait: 10).click
  end

  def go_to_checkout
    find(:xpath, XPATH[:checkout], wait: 10).click
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def displayed?
    has_current_path?(CART_PATH, ignore_query: true) &&
      has_content?(CART_TITLE, wait: 10)
  end

  def displayed_with_product?(product_name)
    displayed? && has_css?(CSS[:cart_item], text: product_name, wait: 10)
  end

  def badge_count
    find(CSS[:cart_badge], wait: 10).text
  end

  def badge_visible?
    has_css?(CSS[:cart_badge], wait: 10)
  end

  def item_visible?(product_name)
    has_css?(CSS[:cart_item], text: product_name, wait: 10)
  end

  def remove_product(product_xpath)
    find(:xpath, product_xpath, wait: 10).click
  end

  def on_checkout_page?
    has_current_path?(CHECKOUT_URL, ignore_query: true) &&
      has_css?(CHECKOUT_INFO_SELECTOR, wait: 10)
  end
end