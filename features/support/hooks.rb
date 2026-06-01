Before('@checkout or @inventory') do
  begin
    Capybara.current_session.driver.quit
  rescue StandardError
  end

  Capybara.reset_sessions!
end

Before '@maximize' do
    page.driver.browser.manage.window.maximize
end