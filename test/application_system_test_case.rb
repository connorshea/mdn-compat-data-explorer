require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :chrome_headless do |app|
    options = ::Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox') if ENV['CI']

    Capybara::Selenium::Driver.new app,
      browser: :chrome,
      options: options,
      service: Selenium::WebDriver::Service.chrome(args: { log_path: 'tmp/chrome.log' })
  end

  Capybara.javascript_driver = :chrome_headless
end
