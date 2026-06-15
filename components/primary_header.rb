require_relative 'burger_menu'

class PrimaryHeaderComponent
  include Capybara::DSL

  ROOT               = '[data-test="header-container"]'.freeze
  BURGER_MENU_BUTTON = '#react-burger-menu-btn'.freeze
  CART               = '[data-test="shopping-cart-link"]'.freeze
  CART_BADGE         = '[data-test="shopping-cart-badge"]'.freeze
  LOGO               = '.app_logo'.freeze

  LOGO_TEXT          = 'Swag Labs'.freeze

  # ─── Actions ───────────────────────────────────────────────────────────────

  def open_burger_menu
    find(BURGER_MENU_BUTTON, wait: 10).click
    @burger_menu = BurgerMenuComponent.new
  end

  def close_burger_menu
    find(BURGER_MENU_BUTTON, wait: 10).click
    @burger_menu = nil
  end

  def open_cart
    find(CART, wait: 10).click
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def loaded? # Whitout burguer menu
    has_css?(ROOT,                   wait: 0.3) &&
    has_css?(LOGO, text: LOGO_TEXT,  wait: 0.3) &&
    has_css?(BURGER_MENU_BUTTON,     wait: 0.3) &&
    has_css?(CART,                   wait: 0.3)
  end

  def loaded_with_menu? # Whit burguer menu
    loaded? && burger_menu.loaded?
  end

  def burger_menu_open?
    burger_menu.loaded?
  end

  def logo
    find(LOGO, wait: 10).text
  end

  def cart_count
    find(CART_BADGE, wait: 10).text
  end

  def cart_badge_visible?
    has_css?(CART_BADGE, wait: 0.3)
  end

  def cart_count_equals?(expected)
    has_css?(CART_BADGE, text: expected, wait: 0.3)
  end

  private

  def burger_menu
    @burger_menu ||= BurgerMenuComponent.new
  end
end