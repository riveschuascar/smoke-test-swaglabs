require_relative 'base_page'
require_relative '../components/inventory_list'
require_relative '../components/burger_menu'

class InventoryPage < BasePage
  attr_reader :inventory_list

  URL = 'https://www.saucedemo.com/inventory.html'.freeze

  def inventory_list
    @inventory_list ||= InventoryListComponent.new
  end

  def burguer_menu
    @burger_menu ||= BurgerMenuComponent.new
  end

  def components
    [inventory_list]
  end
end