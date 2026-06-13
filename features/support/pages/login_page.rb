class LoginPage
  include Capybara::DSL

  LOGIN_URL = 'https://www.saucedemo.com/'
  LOGIN_BUTTON_SELECTOR = '[data-test="login-button"]'
  ERROR_MESSAGE_SELECTOR = '[data-test="error"]'

  def visit_page
    visit(LOGIN_URL)
  end

  def login_as(username, password)
    fill_in 'user-name', with: username
    fill_in 'password', with: password
    click_button 'login-button'
  end

  def displayed?
    has_current_path?('/', ignore_query: true) &&
      has_css?(LOGIN_BUTTON_SELECTOR, wait: 10)
  end

  def error_message
    find(ERROR_MESSAGE_SELECTOR, wait: 10).text
  end
end