class CheckoutPage
  include Capybara::DSL

  CART_URL = '/cart.html'
  STEP_ONE_URL = '/checkout-step-one.html'
  STEP_TWO_URL = '/checkout-step-two.html'
  COMPLETE_URL = '/checkout-complete.html'

  CHECKOUT_BUTTON = '#checkout'
  CONTINUE_BUTTON = '#continue'
  CANCEL_BUTTON = '#cancel'
  FINISH_BUTTON = '#finish'
  ERROR = '[data-test="error"]'

  OVERVIEW_TITLE = 'Checkout: Overview'

  def go_to_step_one
    find(CHECKOUT_BUTTON, wait: 10).click
  end

  def continue
    find(CONTINUE_BUTTON, wait: 10).click
  end

  def cancel
    find(CANCEL_BUTTON, wait: 10).click
  end

  def finish
    find(FINISH_BUTTON, wait: 10).click
  end

  def step_one_displayed?
    has_current_path?(STEP_ONE_URL, ignore_query: true)
  end

  def overview_displayed?
    has_current_path?(STEP_TWO_URL, ignore_query: true) &&
      has_content?(OVERVIEW_TITLE, wait: 10)
  end

  def continue_with_empty_information
    find(CONTINUE_BUTTON, wait: 10).click
  end

  def first_name_required_error_displayed?
    has_css?(
      ERROR,
      text: 'Error: First Name is required',
      wait: 10
    )
  end

  def fill_information(first_name, last_name, postal_code)
    fill_in 'first-name', with: first_name
    fill_in 'last-name', with: last_name
    fill_in 'postal-code', with: postal_code
  end

  def error_message
    find(ERROR, wait: 10).text
  end

  def on_step_one?
    has_current_path?(STEP_ONE_URL, ignore_query: true)
  end

  def on_step_two?
    has_current_path?(STEP_TWO_URL, ignore_query: true) && has_content?('Checkout: Overview')
  end

  def on_cart?
    has_current_path?(CART_URL, ignore_query: true) && has_content?('Your Cart')
  end

  def on_complete?
    has_current_path?(COMPLETE_URL, ignore_query: true) && has_content?('Thank you for your order!')      
  end

  def continue_to_overview
    find(CONTINUE_BUTTON, wait: 10).click
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

  def expected_result_displayed?(expected_page, expected_path, expected_content)
    unless %w[inventory complete].include?(expected_page)
      raise "Unsupported expected checkout result: #{expected_page}"
    end

    has_current_path?(expected_path, ignore_query: true) && has_content?(expected_content, wait: 10)
  end
end