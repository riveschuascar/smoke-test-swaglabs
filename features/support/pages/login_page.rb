class LoginPage
  include Capybara::DSL

  LOGIN_URL = 'https://www.saucedemo.com/'

  LOGIN_BUTTON_SELECTOR  = '[data-test="login-button"]'
  ERROR_MESSAGE_SELECTOR = '[data-test="error"]'
  USERNAME_SELECTOR      = '[data-test="username"]'
  PASSWORD_SELECTOR      = '[data-test="password"]'

  LOGIN_BUTTON_TEXT      = 'Login'
  LOCKED_ERROR           = 'Epic sadface: Sorry, this user has been locked out.'
  INVALID_ERROR          = 'Epic sadface: Username and password do not match any user in this service'
  REQUIRED_ERROR         = 'Epic sadface: Username is required'

  def visit_page
    visit(LOGIN_URL)
  end

  def login_as(username, password)
    fill_in 'user-name', with: username
    fill_in 'password', with: password
    click_button 'Login'
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def displayed?
    has_current_path?('/', ignore_query: true) &&
    has_css?(USERNAME_SELECTOR, wait: 0.2) &&
    has_css?(PASSWORD_SELECTOR, wait: 0.2) &&
    find(LOGIN_BUTTON_SELECTOR, wait: 10).value == LOGIN_BUTTON_TEXT
  end

  # ─── Errors ────────────────────────────────────────────────────────────────

  def error_message
    find(ERROR_MESSAGE_SELECTOR, wait: 10).text
  end

  def locked_out_error_displayed?
    has_css?(ERROR_MESSAGE_SELECTOR, text: LOCKED_ERROR, wait: 0.2)
  end

  def invalid_credentials_error_displayed?
    has_css?(ERROR_MESSAGE_SELECTOR, text: INVALID_ERROR, wait: 0.2)
  end

  def username_required_error_displayed?
    has_css?(ERROR_MESSAGE_SELECTOR, text: REQUIRED_ERROR, wait: 0.2)
  end
end