require_relative 'burger_menu_item'

class BurgerMenuComponent
  include Capybara::DSL

  ROOT = '.bm-menu'.freeze
  ITEM = '.bm-item'.freeze

  EXPECTED_COUNT = 4.freeze
  EXPECTED_ITEMS = BurgerMenuItemComponent::VALID_ITEMS.freeze

  # ─── Actions ───────────────────────────────────────────────────────────────

  def click_item(text)
    find_by_text(text)&.click
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def loaded?
    has_css?(ROOT, wait: 0.2) &&
    count == EXPECTED_COUNT &&
    items.all?(&:loaded?) &&
    all_expected_items_present?
  end

  def count
    items.size
  end

  def item_texts
    items.map(&:text)
  end

  def find_by_text(text)
    items.find { |item| item.text == text }
  end

  private

  def items
    @items ||= find(ROOT, wait: 10).all(ITEM).map { |node| BurgerMenuItemComponent.new(node) }
  end

  def all_expected_items_present?
    EXPECTED_ITEMS.all? { |expected| item_texts.include?(expected) }
  end
end