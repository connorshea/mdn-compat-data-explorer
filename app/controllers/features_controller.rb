class FeaturesController < ApplicationController
  def index
    @features = Feature.first(100)
  end
end
