begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'

Capybara.run_server = false
Capybara.default_max_wait_time = 15

Capybara.register_driver :chrome_testing do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.binary = 'C:/Program Files/Google/Chrome/Application/chrome.exe'

  options.add_argument('--start-maximized')
  options.add_argument('--disable-features=PasswordLeakDetection')
  options.add_argument('--disable-notifications')
  options.add_argument('--disable-popup-blocking')
  options.add_argument('--remote-allow-origins=*')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :chrome_testing
Capybara.javascript_driver = :chrome_testing