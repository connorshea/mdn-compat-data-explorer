class FeaturesController < ApplicationController
  def index
    @features = Feature.first(100)

    # ActiveRecord Query for all css items:
    # Feature.where("name ~* ?", '^css.*')

    @feature_count = Feature.all.count
  end
end
