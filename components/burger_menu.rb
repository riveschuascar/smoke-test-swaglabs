require_relative 'burger_menu_item'

class BurgerMenuComponent
  include Capybara::DSL

  ROOT = '.bm-menu'.freeze
  ITEM = '.bm-item'.freeze

  def items
    @items ||= find(ROOT).all(ITEM).map { |node| BurgerMenuItemComponent.new(node) }
  end

  def loaded?
    has_css?(ROOT) && items.all?(&:loaded?)
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

  def click_item(text)
    find_by_text(text)&.click
  end
end