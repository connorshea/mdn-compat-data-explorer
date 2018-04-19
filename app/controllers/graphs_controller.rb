class GraphsController < ApplicationController
  def index
    @chrome_stats = {
      unknown: Feature.chrome_nil.count,
      yes: Feature.chrome_true.count,
      no: Feature.chrome_false.count
    }

    @firefox_stats = {
      unknown: Feature.firefox_nil.count,
      yes: Feature.firefox_true.count,
      no: Feature.firefox_false.count
    }

    @feature_count = Feature.all.count
  end
end
