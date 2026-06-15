require_relative '../components/login_form'
require_relative 'base_page'

module CleanPOM
  class LoginPage < BasePage
    URL = 'https://www.saucedemo.com/'.freeze

    def components
      [login_form]
    end

    # ─── Actions ─────────────────────────────────────────────────────────────

    def login(username, password)
      login_form.login(username, password)
    end

    # ─── State ───────────────────────────────────────────────────────────────

    def error_displayed?(type)
      login_form.error_displayed?(type)
    end

    def error_message
      login_form.error_message
    end

    private

    def login_form
      @login_form ||= LoginFormComponent.new
    end
  end
end