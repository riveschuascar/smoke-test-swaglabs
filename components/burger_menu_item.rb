class BurgerMenuItemComponent
  include Capybara::DSL

  VALID_ITEMS = [
    'All Items',
    'About',
    'Logout',
    'Reset App State'
  ].freeze

  def initialize(node)
    @node = node
  end

  # ─── Actions ───────────────────────────────────────────────────────────────

  def click
    @node.click
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def loaded?
    @node.tag_name == 'a' &&
    text.length > 0 &&
    VALID_ITEMS.include?(text)
  end

  def text
    @node.text
  end

  def valid?
    VALID_ITEMS.include?(text)
  end
end