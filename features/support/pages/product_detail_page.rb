class ProductDetailPage
  include Capybara::DSL

  DETAIL_NAME_SELECTOR    = '.inventory_details_name'
  DETAIL_PRICE_SELECTOR   = '.inventory_details_price'
  ADD_TO_CART_BUTTON_ID   = '#add-to-cart'
  REMOVE_FROM_CART_ID     = '#remove'
  BACK_BUTTON_ID          = '#back-to-products'
  ITEM_LINKS = {'Sauce Labs Backpack' => '#item_4_title_link'}.freeze

  # Navigation

  def open_from_inventory(product_name)
    selector = ITEM_LINKS.fetch(product_name) do
      raise "No link selector registered for product: '#{product_name}'"
    end
    find(selector, wait: 10).click
  end

  def go_back_to_products
    find(BACK_BUTTON_ID, wait: 10).click
  end

  # State / assertions

  def displayed?
    has_css?(DETAIL_NAME_SELECTOR, wait: 2) &&
      has_css?(DETAIL_PRICE_SELECTOR, wait: 2)
  end

  def name
    find(DETAIL_NAME_SELECTOR, wait: 10).text
  end

  def price
    find(DETAIL_PRICE_SELECTOR, wait: 10).text
  end

  def add_to_cart_visible?
    has_css?(ADD_TO_CART_BUTTON_ID, wait: 2)
  end

  def add_to_cart
    find(ADD_TO_CART_BUTTON_ID, wait: 10).click
  end

  def remove_from_cart
    find(REMOVE_FROM_CART_ID, wait: 10).click
  end
end