class WelcomeController < ApplicationController
  def index
    # ActiveRecord Query for all css items:
    # Feature.where("name ~* ?", '^css.*')

    # Query for all features with an MDN URL:
    @features_with_mdn_count = Feature.where.not(mdn_url: nil).count

    # Query for all features with a description:
    @features_with_description_count = Feature.where.not(description: nil).count

    #  Features where chrome has no set version number.
    # @features_with_chrome_count = Feature.where(chrome: {"version_added"=>nil}).count

    # These should probably be changed to use scopes
    @chrome_features = {
      unknown: Feature.where(chrome: {"version_added": nil}).count,
      true: Feature.where(chrome: {"version_added": true}).count,
      false: Feature.where(chrome: {"version_added": false}).count
    }

    @features_with_webview_android_count = Feature.where.not(webview_android: nil).count

    @standard_features = Feature.where(standard_track: true).count
    @experimental_features = Feature.where(experimental: true).count
    @deprecated_features = Feature.where(deprecated: true).count

    @feature_count = Feature.all.count
  end
end
