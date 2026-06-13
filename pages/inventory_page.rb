require_relative 'base_page'
require_relative '../components/inventory_list'
require_relative '../components/primary_header'

module CleanPOM
  class InventoryPage < BasePage
    attr_reader :inventory_list

    URL = 'https://www.saucedemo.com/inventory.html'.freeze

    def primary_header
      @primary_header ||= PrimaryHeaderComponent.new
    end

    def inventory_list
      @inventory_list ||= InventoryListComponent.new
    end

    def open_burguer_menu
      primary_header.open_burguer_menu
    end

    def components
      [primary_header, inventory_list]
    end
  end
end