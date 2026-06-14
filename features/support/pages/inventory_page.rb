class InventoryPage
  include Capybara::DSL

  INVENTORY_URL = 'https://www.saucedemo.com/inventory.html'
  INVENTORY_LIST_SELECTOR = '.inventory_list'
  SORT_SELECTOR = '.product_sort_container'
  ITEM_NAME_SELECTOR = '.inventory_item_name'
  ITEM_PRICE_SELECTOR = '.inventory_item_price'

  def product_names
    all(ITEM_NAME_SELECTOR, wait: 10).map(&:text)
  end
  
  def visit_directly
    visit(INVENTORY_URL)
  end

  def displayed?
    has_current_path?('/inventory.html', ignore_query: true) &&
      has_css?(INVENTORY_LIST_SELECTOR, wait: 10)
  end

  def sort_by(option)
    find(SORT_SELECTOR, wait: 10).select(option)
  end

  def first_item_name
    all(ITEM_NAME_SELECTOR).first.text
  end

  def first_item_price
    all(ITEM_PRICE_SELECTOR).first.text
  end

  def first_item_value(field)
    case field
    when 'name'
      first_item_name
    when 'price'
      first_item_price
    else
      raise "Unsupported inventory field: #{field}"
    end
  end
end