require_relative 'burger_menu'

class PrimaryHeaderComponent
  include Capybara::DSL

  ROOT = '[data-test="header-container"]'.freeze
  BURGER_MENU_BUTTON = '#react-burger-menu-btn'.freeze
  CART = '[data-test="shopping-cart-link"]'.freeze
  LOGO = '.app-logo'.freeze

  def loaded?
    has_css?(ROOT) && has_css?(BURGER_MENU_BUTTON) && has_css?(CART)
  end

  def burger_menu_button
    find(BURGER_MENU_BUTTON)
  end

  def open_burguer_menu
    burger_menu_button.click
    BurgerMenuComponent.new
  end

  def logo
    find(LOGO).text
  end

  def cart
    find(CART)
  end

  def cart_count
    find('[data-test="shopping-cart-badge"]').text
  end

  def open_cart
    cart.click
  end
end