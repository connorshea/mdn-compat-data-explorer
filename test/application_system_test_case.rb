require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  browser_options = %w[headless]
  browser_options << 'no-sandbox' if ENV['CI']

  driven_by(
    :selenium,
    using: :chrome,
    screen_size: [1400, 1400],
    options: {
      desired_capabilities: {
        chromeOptions: {
          args: browser_options
        }
      }
    }
  )
end
