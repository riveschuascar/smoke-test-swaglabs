class CartPage
  include Capybara::DSL

  CART_PATH             = '/cart.html'
  CART_TITLE            = 'Your Cart'
  CART_TITLE_SELECTOR   = '[data-test="title"]'
  CHECKOUT_INFO_SELECTOR = '[data-test="checkout-info-container"]'
  CHECKOUT_URL          = 'https://www.saucedemo.com/checkout-step-one.html'

  XPATH = {
    continue_shopping: "//*[@data-test='continue-shopping']",
    checkout:          "//*[@data-test='checkout']",
    cart_link:         "//a[contains(@class, 'shopping_cart_link')]"
  }.freeze

  CSS = {
    cart_badge: '[data-test="shopping-cart-badge"]',
    cart_item:  '[data-test="inventory-item-name"]'
  }.freeze

  CART_PRODUCTS = {
    'Sauce Labs Backpack' => {
      inventory_add:    "//*[@data-test='add-to-cart-sauce-labs-backpack']",
      inventory_remove: "//*[@data-test='remove-sauce-labs-backpack']",
      detail_add:       "//*[@data-test='add-to-cart']",
      detail_remove:    "//*[@data-test='remove']",
      cart_remove:      "//*[@data-test='remove-sauce-labs-backpack']"
    }
  }.freeze

  # ─── Navigation ──────────────────────────────────────────────────────────

  def open
    find(:xpath, XPATH[:cart_link], wait: 10).click
  end

  def continue_shopping
    find(:xpath, XPATH[:continue_shopping], wait: 10).click
  end

  def go_to_checkout
    find(:xpath, XPATH[:checkout], wait: 10).click
  end

  # ─── State ───────────────────────────────────────────────────────────────

  def displayed?
    has_current_path?(CART_PATH, ignore_query: true) &&
    has_css?(CART_TITLE_SELECTOR, text: CART_TITLE, wait: 0.2)
  end

  def displayed_with_product?(product_name)
    displayed? && has_css?(CSS[:cart_item], text: product_name, wait: 10)
  end

  def badge_count
    find(CSS[:cart_badge], wait: 10).text
  end

  def badge_visible?
    has_css?(CSS[:cart_badge], wait: 0.2)
  end

  def item_visible?(product_name)
    has_css?(CSS[:cart_item], text: product_name, wait: 0.2)
  end

  def remove_product(product_xpath)
    find(:xpath, product_xpath, wait: 10).click
  end

  def on_checkout_page?
    has_current_path?(CHECKOUT_URL, ignore_query: true) &&
    has_css?(CHECKOUT_INFO_SELECTOR, wait: 0.2)
  end

  def cart_product(product_name)
    CART_PRODUCTS.fetch(product_name) do
      raise "Producto no registrado en CART_PRODUCTS: '#{product_name}'"
    end
  end
end