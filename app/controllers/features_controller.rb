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
    # ActiveRecord Query for all css items:
    # Feature.where("name ~* ?", '^css.*')

    # Query for all features with an MDN URL:
    # @features_with_mdn_count = Feature.where.not(mdn_url: nil).count

    # Query for all features with a description:
    # @features_with_description_count = Feature.where.not(description: nil).count

    @features = Feature.all.page params[:page]
    @feature_count = Feature.all.count
    @browsers = BROWSERS
  end

  def api
    @features = Feature.where("name ~* ?", '^api.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^api.*').count
    @browsers = BROWSERS
  end

  def css
    @features = Feature.where("name ~* ?", '^css.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^css.*').count
    @browsers = BROWSERS
  end

  def html
    @features = Feature.where("name ~* ?", '^html.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^html.*').count
    @browsers = BROWSERS
  end

  def http
    @features = Feature.where("name ~* ?", '^http.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^http.*').count
    @browsers = BROWSERS
  end

  def javascript
    @features = Feature.where("name ~* ?", '^javascript.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^javascript.*').count
    @browsers = BROWSERS
  end

  def mathml
    @features = Feature.where("name ~* ?", '^mathml.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^mathml.*').count
    @browsers = BROWSERS
  end

  def svg
    @features = Feature.where("name ~* ?", '^svg.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^svg.*').count
    @browsers = BROWSERS
  end

  def webdriver
    @features = Feature.where("name ~* ?", '^webdriver.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^webdriver.*').count
    @browsers = BROWSERS
  end

  def webextensions
    @features = Feature.where("name ~* ?", '^webextensions.*').page params[:page]
    @feature_count = Feature.where("name ~* ?", '^webextensions.*').count
    @browsers = BROWSERS
  end
end
