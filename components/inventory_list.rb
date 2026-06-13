require_relative 'inventory_item'

class InventoryListComponent
  include Capybara::DSL

  ROOT = '[data-test="inventory-list"]'.freeze
  ITEM = '[data-test="inventory-item"]'.freeze

  def items
    @items ||= find(ROOT).all(ITEM).map { |node| InventoryItemComponent.new(node) }
  end

  def loaded?
    has_css?(self.class::ROOT) && items.all?(&:loaded?)
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

  def add_product_to_cart(product_name)
    find_by_name(product_name)&.add_to_cart
  end
end