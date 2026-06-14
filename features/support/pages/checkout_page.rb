class CheckoutPage
  include Capybara::DSL

  STEP_ONE_PATH = '/checkout-step-one.html'
  STEP_TWO_PATH = '/checkout-step-two.html'
  OVERVIEW_TITLE = 'Checkout: Overview'
  ERROR_MESSAGE_SELECTOR = '[data-test="error"]'
  CONTINUE_BUTTON_SELECTOR = '#continue'
  CANCEL_BUTTON_SELECTOR = '#cancel'
  FINISH_BUTTON_SELECTOR = '#finish'

  def step_one_displayed?
    has_current_path?(STEP_ONE_PATH, ignore_query: true)
  end

  def overview_displayed?
    has_current_path?(STEP_TWO_PATH, ignore_query: true) &&
      has_content?(OVERVIEW_TITLE, wait: 10)
  end

  def continue_with_empty_information
    find(CONTINUE_BUTTON_SELECTOR, wait: 10).click
  end

  def first_name_required_error_displayed?
    has_css?(
      ERROR_MESSAGE_SELECTOR,
      text: 'Error: First Name is required',
      wait: 10
    )
  end

  def cancel_from_step_one
    find(CANCEL_BUTTON_SELECTOR, wait: 10).click
  end

  def fill_information(first_name, last_name, postal_code)
    fill_in 'first-name', with: first_name
    fill_in 'last-name', with: last_name
    fill_in 'postal-code', with: postal_code
  end

  def continue_to_overview
    find(CONTINUE_BUTTON_SELECTOR, wait: 10).click
  end

  def perform_step_two_action(action)
    case action
    when 'cancel'
      find(CANCEL_BUTTON_SELECTOR, wait: 10).click
    when 'finish'
      find(FINISH_BUTTON_SELECTOR, wait: 10).click
    else
      raise "Unsupported checkout step two action: #{action}"
    end
  end

  def expected_result_displayed?(expected_page, expected_path, expected_content)
    unless %w[inventory complete].include?(expected_page)
      raise "Unsupported expected checkout result: #{expected_page}"
    end

    has_current_path?(expected_path, ignore_query: true) &&
      has_content?(expected_content, wait: 10)
  end
end