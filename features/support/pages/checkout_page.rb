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
  ERROR_SELECTOR = '[data-test="error"]'

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

  def fill_information(first_name, last_name, postal_code)
    fill_in 'first-name', with: first_name
    fill_in 'last-name', with: last_name
    fill_in 'postal-code', with: postal_code
  end

  def error_message
    find(ERROR_SELECTOR, wait: 10).text
  end

  def on_step_one?
    has_current_path?(STEP_ONE_URL, ignore_query: true)
  end

  def on_step_two?
    has_current_path?(STEP_TWO_URL, ignore_query: true) &&
      has_content?('Checkout: Overview')
  end

  def on_cart?
    has_current_path?(CART_URL, ignore_query: true) &&
      has_content?('Your Cart')
  end

  def on_complete?
    has_current_path?(COMPLETE_URL, ignore_query: true) &&
      has_content?('Thank you for your order!')
  end
end