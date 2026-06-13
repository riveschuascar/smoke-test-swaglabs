class BurgerMenuItemComponent
  include Capybara::DSL

  def initialize(node)
    @node = node
  end

  def loaded?
    @node.tag_name == 'a'
  end

  def text
    @node.text
  end

  def click
    @node.click
  end
end