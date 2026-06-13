class InventoryItemComponent
  include Capybara::DSL

  ROOT = '[data-test="inventory-item"]'.freeze

  def initialize(node)
    @node = node
  end

  def loaded?
    @node.has_css?('[data-test="inventory-item-name"]') && @node.has_css?('[data-test="inventory-item-price"]')
  end

  def name
    @node.find('[data-test="inventory-item-name"]').text
  end

  def price
    @node.find('[data-test="inventory-item-price"]').text
  end

  def add_to_cart
    @node.find('button[data-test^="add-to-cart"]').click
  end

  def open
    @node.find('[data-test$="-title-link"]').click
  end
end