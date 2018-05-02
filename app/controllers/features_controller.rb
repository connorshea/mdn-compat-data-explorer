class FeaturesController < ApplicationController
  def index
    if params[:query].present?
      features = Feature.search(params[:query])
    else
      features = Feature.all
    end

    @categories = Rails.configuration.feature_categories

    category_params = []

    @categories.keys.each do |category|
      if params["categories"].present? && params["categories"].include?(category.to_s)
        category_params.push(category.to_s)
      end
    end

    category_params.each_with_index do |category, i|
      if i == 0
        features = features.where("name ~* ?", "^#{category}.*")
      else
        features = features.or(Feature.where("name ~* ?", "^#{category}.*"))
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
