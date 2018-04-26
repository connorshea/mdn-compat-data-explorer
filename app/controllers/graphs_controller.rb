class GraphsController < ApplicationController
  def index
    @browser_stats = Hash.new

    [:chrome, :firefox].each do |browser|
      stats = {
        unknown: Feature.public_send("#{browser}_nil").count,
        yes: Feature.public_send("#{browser}_true").count,
        no: Feature.public_send("#{browser}_false").count,
        no_data: Feature.public_send("#{browser}_no_data").count
      }

      @browser_stats[browser] = stats
    end

    @feature_count = Feature.all.count
  end
end
