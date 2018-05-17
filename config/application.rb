require_relative 'boot'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MdnCompatDataExplorer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Set the version of the MDN BCD Package
    config.mdn_bcd_version = '0.0.35'

    Rails.application.config.assets.configure do |env|
      AutoprefixerRails.uninstall env
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set feature categories in the environment so we can remove some
    # categories when running tests.
    config.feature_categories = {
      api: "API",
      css: "CSS",
      html: "HTML",
      http: "HTTP",
      javascript: "JavaScript",
      mathml: "MathML",
      svg: "SVG",
      webdriver: "WebDriver",
      webextensions: "WebExtensions"
    }

    # Set browsers in the environment so we can remove some
    # browsers when running tests.
    config.browsers = {
      chrome: "Chrome",
      chrome_android: "Chrome Android",
      edge: "Edge",
      edge_mobile: "Edge Mobile",
      firefox: "Firefox",
      firefox_android: "Firefox Android",
      ie: "Internet Explorer",
      nodejs: "NodeJS",
      opera: "Opera",
      qq_android: "QQ Android",
      safari: "Safari",
      safari_ios: "Safari Mobile",
      samsunginternet_android: "Samsung Internet for Android",
      uc_android: "UC Browser for Android",
      uc_chinese_android: "Chinese UC Browser for Android",
      webview_android: "Android Webview"
    }
  end
end
