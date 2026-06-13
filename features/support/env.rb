begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'tmpdir'
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
  options.add_argument("--user-data-dir=#{Dir.mktmpdir}")
  options.add_argument('--guest')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :chrome_testing
Capybara.javascript_driver = :chrome_testing
Dir[File.join(__dir__, 'pages', '*.rb')].sort.each { |file| require file }
