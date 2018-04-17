class FeaturesController < ApplicationController
  def index
    @features = Feature.first(100)

    @feature_count = Feature.all.count
  end
end
