require_relative 'inventory_item'

class InventoryListComponent
  include Capybara::DSL

  ROOT = '[data-test="inventory-list"]'.freeze
  ITEM = '[data-test="inventory-item"]'.freeze

  EXPECTED_COUNT = 6.freeze
  EXPECTED_PRODUCTS = [
    { name: 'Sauce Labs Backpack',           price: '$29.99' },
    { name: 'Sauce Labs Bike Light',         price: '$9.99'  },
    { name: 'Sauce Labs Bolt T-Shirt',       price: '$15.99' },
    { name: 'Sauce Labs Fleece Jacket',      price: '$49.99' },
    { name: 'Sauce Labs Onesie',             price: '$7.99'  },
    { name: 'Test.allTheThings() T-Shirt',   price: '$15.99' }
  ].freeze

  # ─── Actions ───────────────────────────────────────────────────────────────

  def add_product_to_cart(product_name)
    find_by_name(product_name)&.add_to_cart
  end

  def open_product(product_name)
    find_by_name(product_name)&.open
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def loaded?
    has_css?(ROOT, wait: 0.3) &&
    count == EXPECTED_COUNT &&
    items.all?(&:loaded?)
  end

  def correct_products_displayed?
    EXPECTED_PRODUCTS.all? do |product|
      find_by_name(product[:name])&.correct_product?(product[:name], product[:price])
    end
  end

  def count
    items.size
  end

  def product_names
    items.map(&:name)
  end

  def find_by_name(product_name)
    items.find { |item| item.name == product_name }
  end

  private

  def items
    @items ||= find(ROOT, wait: 10).all(ITEM).map { |node| InventoryItemComponent.new(node) }
  end
end