class LoginFormComponent
  include Capybara::DSL

  ROOT = '#login_button_container'.freeze

  USERNAME_INPUT = '[data-test="username"]'.freeze
  PASSWORD_INPUT = '[data-test="password"]'.freeze
  LOGIN_BUTTON   = '[data-test="login-button"]'.freeze
  ERROR_MESSAGE  = '[data-test="error"]'.freeze

  LOGIN_BUTTON_TEXT = 'Login'.freeze

  ERROR_MESSAGES = {
    locked:           'Epic sadface: Sorry, this user has been locked out.',
    invalid:          'Epic sadface: Username and password do not match any user in this service',
    username_required: 'Epic sadface: Username is required',
    password_required: 'Epic sadface: Password is required'
  }.freeze

  # ─── Actions ───────────────────────────────────────────────────────────────

  def fill_username(username)
    find(USERNAME_INPUT, wait: 10).set(username)
  end

  def fill_password(password)
    find(PASSWORD_INPUT, wait: 10).set(password)
  end

  def click_login
    find(LOGIN_BUTTON, wait: 10).click
  end

  def login(username, password)
    fill_username(username)
    fill_password(password)
    click_login
  end

  # ─── State ─────────────────────────────────────────────────────────────────

  def loaded?
    has_css?(USERNAME_INPUT,  wait: 0.2) &&
    has_css?(PASSWORD_INPUT,  wait: 0.2) &&
    find(LOGIN_BUTTON, wait: 10).value == LOGIN_BUTTON_TEXT
  end

  # ─── Errors ────────────────────────────────────────────────────────────────

  def error_message
    find(ERROR_MESSAGE, wait: 10).text
  end

  def error_displayed?(message)
    full_message = ERROR_MESSAGES.values.find { |v| v.include?(message) } || message
    has_css?(ERROR_MESSAGE, text: full_message, wait: 0.2)
  end
end