begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'

Capybara.run_server = false

Capybara.default_driver = :selenium 
Capybara.default_max_wait_time = 15

Capybara.register_driver :chrome_testing do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--start-maximized')
  options.add_argument('--disable-features=PasswordLeakDetection') # Desactivar el popup por contrasena filtrada
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Asignamos el driver registrado como el predeterminado para tus pruebas
Capybara.default_driver = :chrome_testing
Capybara.javascript_driver = :chrome_testing 

#World(Capybara)
Capybara.default_driver = :chrome_testing 
Capybara.javascript_driver = :chrome_testing 
