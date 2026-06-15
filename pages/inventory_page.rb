require_relative 'base_page'
require_relative '../components/inventory_list'
require_relative '../components/primary_header'

module CleanPOM
  class InventoryPage < BasePage
    URL = 'https://www.saucedemo.com/inventory.html'.freeze

    def components
      [primary_header, inventory_list]
    end

    # ─── Actions ─────────────────────────────────────────────────────────────

    def open_burger_menu
      primary_header.open_burger_menu
    end

    def open_cart
      primary_header.open_cart
    end

    def add_product_to_cart(product_name)
      inventory_list.add_product_to_cart(product_name)
    end

    def open_product(product_name)
      inventory_list.open_product(product_name)
    end

    # ─── State ───────────────────────────────────────────────────────────────

    def correct_products_displayed?
      inventory_list.correct_products_displayed?
    end

    def product_names
      inventory_list.product_names
    end

    def cart_count_equals?(expected)
      primary_header.cart_count_equals?(expected)
    end

    def cart_badge_visible?
      primary_header.cart_badge_visible?
    end

    def displayed? # Keep while migrate to Page Object + Component Object pattern
      loaded?
    end

    private

    def primary_header
      @primary_header ||= PrimaryHeaderComponent.new
    end

    def inventory_list
      @inventory_list ||= InventoryListComponent.new
    end
  end
end