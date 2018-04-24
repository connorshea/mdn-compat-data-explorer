class FeaturesController < ApplicationController
  BROWSERS = [
    "chrome",
    "chrome_android",
    "edge",
    "edge_mobile",
    "firefox",
    "firefox_android",
    "ie",
    "opera",
    "safari",
    "safari_ios",
    "webview_android"
  ]

  BROWSERS_PLUS_NODE = [
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
    @features = Feature.all.page params[:page]
    @feature_count = Feature.all.count
    @browsers = BROWSERS_PLUS_NODE
    
    @search = true
  end

  def api
    @features = Feature.api.page params[:page]
    @feature_count = Feature.api.count
    @browsers = BROWSERS
  end

  def css
    @features = Feature.css.page params[:page]
    @feature_count = Feature.css.count
    @browsers = BROWSERS
  end

  def html
    @features = Feature.html.page params[:page]
    @feature_count = Feature.html.count
    @browsers = BROWSERS
  end

  def http
    @features = Feature.http.page params[:page]
    @feature_count = Feature.http.count
    @browsers = BROWSERS
  end

  def javascript
    @features = Feature.javascript.page params[:page]
    @feature_count = Feature.javascript.count
    @browsers = BROWSERS_PLUS_NODE
  end

  def mathml
    @features = Feature.mathml.page params[:page]
    @feature_count = Feature.mathml.count
    @browsers = BROWSERS
  end

  def svg
    @features = Feature.svg.page params[:page]
    @feature_count = Feature.svg.count
    @browsers = BROWSERS
  end

  def webdriver
    @features = Feature.webdriver.page params[:page]
    @feature_count = Feature.webdriver.count
    @browsers = BROWSERS
  end

  def webextensions
    @features = Feature.webextensions.page params[:page]
    @feature_count = Feature.webextensions.count
    @browsers = BROWSERS
  end

  def search
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
      if params[category].present? && params[category]
        features = features.public_send(category)
      end
    end

    @features = features.page(params[:page])

    @browsers = BROWSERS_PLUS_NODE

    @search_page = true
    @search = true
  end
end
