class WelcomeController < ApplicationController
  def index
    # Query for all features with an MDN URL:
    @features_with_mdn_count = Feature.has_mdn_url.count

    # Query for all features with a description:
    @features_with_description_count = Feature.has_description.count

    #  Features where chrome has no set version number.
    # @features_with_chrome_count = Feature.where(chrome: {"version_added"=>nil}).count

    # These should probably be changed to use scopes
    @chrome_features = {
      unknown: Feature.where(chrome: {"version_added": nil}).count,
      true: Feature.where(chrome: {"version_added": true}).count,
      false: Feature.where(chrome: {"version_added": false}).count
    }

    @features_with_webview_android_count = Feature.where.not(webview_android: nil).count

    @standard_features = Feature.is_on_standard_track.count
    @experimental_features = Feature.is_experimental.count
    @deprecated_features = Feature.is_deprecated.count

    @feature_count = Feature.all.count
  end
end
