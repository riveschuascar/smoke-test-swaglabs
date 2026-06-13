class BasePage
  include Capybara::DSL

  def initialize
    raise NotImplementedError, "#{self.class} must define URL" unless self.class.const_defined?(:URL)
  end

  def components
    []
  end

  def loaded?
    has_current_path?(self.class::URL, ignore_query: true) && components.all?(&:loaded?)
  end

  def open
    visit(self.class::URL)
  end
end