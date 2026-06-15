class CheckoutPage
  include Capybara::DSL

  CART_URL     = '/cart.html'
  STEP_ONE_URL = '/checkout-step-one.html'
  STEP_TWO_URL = '/checkout-step-two.html'
  COMPLETE_URL = '/checkout-complete.html'

  # Botones con data-test
  CHECKOUT_BUTTON = '[data-test="checkout"]'
  CONTINUE_BUTTON = '[data-test="continue"]'
  CANCEL_BUTTON   = '[data-test="cancel"]'
  FINISH_BUTTON   = '[data-test="finish"]'
  ERROR_SELECTOR  = '[data-test="error"]'

  # Títulos con data-test
  TITLE_SELECTOR          = '[data-test="title"]'
  COMPLETE_HEADER_SELECTOR = '[data-test="complete-header"]'

  OVERVIEW_TITLE  = 'Checkout: Overview'
  CART_TITLE      = 'Your Cart'
  COMPLETE_TITLE  = 'Thank you for your order!'

  # ─── Actions ───────────────────────────────────────────────────────────────

  def go_to_step_one
    find(CHECKOUT_BUTTON, wait: 10).click
  end

  def continue
    find(CONTINUE_BUTTON, wait: 10).click
  end

  def continue_to_overview
    find(CONTINUE_BUTTON, wait: 10).click
  end

  def continue_with_empty_information
    find(CONTINUE_BUTTON, wait: 10).click
  end

  def cancel
    find(CANCEL_BUTTON, wait: 10).click
  end

  def finish
    find(FINISH_BUTTON, wait: 10).click
  end

  def fill_information(first_name, last_name, postal_code)
    fill_in 'first-name', with: first_name
    fill_in 'last-name', with: last_name
    fill_in 'postal-code', with: postal_code
  end

  def perform_step_two_action(action)
    case action
    when 'cancel'
      find(CANCEL_BUTTON, wait: 10).click
    when 'finish'
      find(FINISH_BUTTON, wait: 10).click
    else
      raise "Unsupported checkout step two action: #{action}"
    end
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def step_one_displayed?
    has_current_path?(STEP_ONE_URL, ignore_query: true) &&
    has_css?(CONTINUE_BUTTON, wait: 0.2)
  end

  def overview_displayed?
    has_current_path?(STEP_TWO_URL, ignore_query: true) &&
    has_css?(TITLE_SELECTOR, text: OVERVIEW_TITLE, wait: 0.2)
  end

  def overview_information_displayed?(expected)
    has_text?("Item total: #{expected['item_total']}", wait: 0.2) &&
    has_text?("Tax: #{expected['tax']}", wait: 0.2) &&
    has_text?("Total: #{expected['total']}", wait: 0.2) &&
    has_text?(expected['card'], wait: 0.2) &&
    has_text?(expected['shippin'], wait: 0.2)
  end

  def on_step_one?
    has_current_path?(STEP_ONE_URL, ignore_query: true) &&
      has_css?(CONTINUE_BUTTON, wait: 2)
  end

  def on_step_two?
    has_current_path?(STEP_TWO_URL, ignore_query: true) &&
    has_css?(TITLE_SELECTOR, text: OVERVIEW_TITLE, wait: 0.2)
  end

  def on_cart?
    has_current_path?(CART_URL, ignore_query: true) &&
    has_css?(TITLE_SELECTOR, text: CART_TITLE, wait: 0.2)
  end

  def on_complete?
    has_current_path?(COMPLETE_URL, ignore_query: true) &&
    has_css?(COMPLETE_HEADER_SELECTOR, text: COMPLETE_TITLE, wait: 0.2)
  end

  def expected_result_displayed?(expected_page, expected_path, expected_content)
    has_current_path?(expected_path, ignore_query: true) &&
    has_text?(expected_content, wait: 0.2)
  end

  # ─── Errors ────────────────────────────────────────────────────────────────

  def error_message
    find(ERROR_SELECTOR, wait: 10).text
  end

  def first_name_required_error_displayed?
    has_css?(ERROR_SELECTOR, text: 'Error: First Name is required', wait: 0.2)
  end
end
