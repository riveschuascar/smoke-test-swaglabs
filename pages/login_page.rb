require_relative '../components/login_form'
require_relative 'base_page'

module CleanPOM
  class LoginPage < BasePage
    URL = 'https://www.saucedemo.com/'

    def login_form
      @login_form ||= LoginFormComponent.new
    end

    def components
      [login_form]
    end
  end
end