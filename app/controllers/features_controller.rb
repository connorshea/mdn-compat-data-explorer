class FeaturesController < ApplicationController
  BROWSERS = [
    "chrome",
    "chrome_android",
    "edge",
    "edge_mobile",
    "firefox",
    "firefox_android",
    "ie",
    "nodejs",
    "opera",
    "safari",
    "safari_ios",
    "webview_android"
  ]

  def index
    if params[:query].present?
      features = Feature.search(params[:query])
    else
      features = Feature.all
    end

    @categories = {
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

    @categories.keys.each do |category|
      if params["category"].present? && params["category"] == category.to_s
        features = features.public_send(category)
      end
    end

    @features = features.page(params[:page])

    @browsers = BROWSERS

    @search_page = true
    @search = true
  end
end
