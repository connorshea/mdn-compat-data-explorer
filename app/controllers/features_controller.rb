class FeaturesController < ApplicationController
  def index
    @features = Feature.first(100)

    # ActiveRecord Query for all css items:
    # Feature.where("name ~* ?", '^css.*')

    # Query for all features with an MDN URL:
    # @features_with_mdn_count = Feature.where.not(mdn_url: nil).count

    # Query for all features with a description:
    # @features_with_description_count = Feature.where.not(description: nil).count

    @feature_count = Feature.all.count
  end
end
