class LoginFormComponent
  include Capybara::DSL

  ROOT = '["login_button_container"]'.freeze

  USERNAME_INPUT = '[data-test="username"]'.freeze
  PASSWORD_INPUT = '[data-test="password"]'.freeze
  LOGIN_BUTTON   = '[data-test="login-button"]'.freeze

  ERROR_MESSAGE  = '[data-test="error"]'.freeze

  def loaded?
    has_css?(USERNAME_INPUT) && has_css?(PASSWORD_INPUT) && has_css?(LOGIN_BUTTON)
  end

  def fill_username(username)
    find(USERNAME_INPUT).set(username)
  end

  def fill_password(password)
    find(PASSWORD_INPUT).set(password)
  end

  def click_login
    find(LOGIN_BUTTON).click
  end

  def error_message
    find(ERROR_MESSAGE).text
  end
end