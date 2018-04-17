class FeaturesController < ApplicationController
  def index
    @features = Feature.first(100)

    # ActiveRecord Query for all css items:
    # Feature.where("name ~* ?", '^css.*')

    # Query for all features with an MDN URL:
    # @features_with_mdn = Feature.where.not(mdn_url: nil)

    @feature_count = Feature.all.count
  end
end
