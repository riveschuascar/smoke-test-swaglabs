require_relative '../components/inventory_list'
require_relative 'base_page'

class InventoryPage < BasePage
  attr_reader :inventory_list

  URL = 'https://www.saucedemo.com/inventory.html'.freeze

  def inventory_list
    @inventory_list ||= InventoryListComponent.new
  end

  def components
    [inventory_list]
  end
end