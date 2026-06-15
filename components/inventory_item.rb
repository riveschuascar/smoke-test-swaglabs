class InventoryItemComponent
  include Capybara::DSL

  ROOT = '[data-test="inventory-item"]'.freeze

  NAME_SELECTOR    = '[data-test="inventory-item-name"]'.freeze
  PRICE_SELECTOR   = '[data-test="inventory-item-price"]'.freeze
  ADD_CART_SELECTOR = 'button[data-test^="add-to-cart"]'.freeze
  TITLE_SELECTOR   = '[data-test$="-title-link"]'.freeze

  def initialize(node)
    @node = node
  end

  # ─── Actions ───────────────────────────────────────────────────────────────

  def add_to_cart
    @node.find(ADD_CART_SELECTOR, wait: 10).click
  end

  def open
    @node.find(TITLE_SELECTOR, wait: 10).click
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def loaded?
    @node.has_css?(NAME_SELECTOR, wait: 0.3) &&
    @node.has_css?(PRICE_SELECTOR, wait: 0.3) &&
    name.length > 0 &&
    price.match?(/^\$[\d]+\.[\d]{2}$/)
  end

  def name
    @node.find(NAME_SELECTOR, wait: 10).text
  end

  def price
    @node.find(PRICE_SELECTOR, wait: 10).text
  end

  def correct_product?(expected_name, expected_price)
    @node.has_css?(NAME_SELECTOR,  text: expected_name,  wait: 0.3) &&
    @node.has_css?(PRICE_SELECTOR, text: expected_price, wait: 0.3)
  end
end