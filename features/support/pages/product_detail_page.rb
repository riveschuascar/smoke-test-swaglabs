class ProductDetailPage
  include Capybara::DSL

  DETAIL_NAME_SELECTOR  = '[data-test="inventory-item-name"]'
  DETAIL_PRICE_SELECTOR = '[data-test="inventory-item-price"]'
  ADD_TO_CART_SELECTOR  = '[data-test="add-to-cart"]'
  REMOVE_SELECTOR       = '[data-test="remove"]'
  BACK_BUTTON_SELECTOR  = '[data-test="back-to-products"]'

  ITEM_LINKS = {
    'Sauce Labs Backpack' => '[data-test="item-4-title-link"]'
  }.freeze

  PRODUCT_DATA = {
    'Sauce Labs Backpack' => {
      name:  'Sauce Labs Backpack',
      price: '$29.99'
    }
  }.freeze

  ADD_TO_CART_TEXT  = 'Add to cart'
  BACK_BUTTON_TEXT  = 'Back to products'

  # ─── Navigation ────────────────────────────────────────────────────────────

  def open_from_inventory(product_name)
    selector = ITEM_LINKS.fetch(product_name) do
      raise "No link selector registered for product: '#{product_name}'"
    end
    find(selector, wait: 10).click
  end

  def go_back_to_products
    find(BACK_BUTTON_SELECTOR, wait: 10).click
  end

  def add_to_cart
    find(ADD_TO_CART_SELECTOR, wait: 10).click
  end

  def remove_from_cart
    find(REMOVE_SELECTOR, wait: 10).click
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def displayed?
    has_css?(DETAIL_NAME_SELECTOR,  wait: 0.2) &&
    has_css?(DETAIL_PRICE_SELECTOR, wait: 0.2) &&
    has_css?(ADD_TO_CART_SELECTOR,  wait: 0.2) &&
    has_css?(BACK_BUTTON_SELECTOR,  wait: 0.2)
  end

  def correct_product?(expected)
    has_css?(DETAIL_NAME_SELECTOR,  text: expected['title'], wait: 0.2) &&
    has_css?(DETAIL_PRICE_SELECTOR, text: expected['price'], wait: 0.2)
  end

  def name
    find(DETAIL_NAME_SELECTOR, wait: 10).text
  end

  def price
    find(DETAIL_PRICE_SELECTOR, wait: 10).text
  end

  def correct_product_displayed?(product_name)
    data = PRODUCT_DATA.fetch(product_name) do
      raise "Producto no registrado en PRODUCT_DATA: '#{product_name}'"
    end

    has_css?(DETAIL_NAME_SELECTOR,  text: data[:name],  wait: 0.2) &&
    has_css?(DETAIL_PRICE_SELECTOR, text: data[:price], wait: 0.2)
  end

  def add_to_cart_visible?
    has_css?(ADD_TO_CART_SELECTOR, text: ADD_TO_CART_TEXT, wait: 0.2)
  end

  def remove_visible?
    has_css?(REMOVE_SELECTOR, text: 'Remove', wait: 0.2)
  end
end