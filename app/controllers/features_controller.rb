class FeaturesController < ApplicationController
  def index
    if params[:query].present?
      features = Feature.search(params[:query])
    else
      features = Feature.all
    end

    @categories = Rails.configuration.feature_categories

    @categories.keys.each do |category|
      if params["category"].present? && params["category"] == category.to_s
        features = features.public_send(category)
      end
    end

    @feature_count = features.count
    @features = features.page(params[:page])

    @browsers = Rails.configuration.browsers
    
    [:qq_android, :uc_android, :uc_chinese_android, :samsunginternet_android].each do |browser|
      @browsers.delete(browser)
    end
  end
end
