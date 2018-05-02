class FeaturesController < ApplicationController
  def index
    if params[:query].present?
      features = Feature.search(params[:query])
    else
      features = Feature.all
    end

    # Handle categories array. Categories can be filtered down to, e.g.
    # "css and javascript", but each feature only has one category so we have
    # to use an OR relation when passed multiple categories.
    @categories = Rails.configuration.feature_categories
    i = 0
    @categories.keys.each do |category|
      if params["categories"].present? && params["categories"].include?(category.to_s)
        if i == 0
          features = features.where("name ~* ?", "^#{category}.*")
        else
          features = features.or(Feature.where("name ~* ?", "^#{category}.*"))
        end
        i += 1
      end
    end

    # Handles filtering based on the presence of an MDN URL.
    if params["mdn_url"] == "true"
      features = features.has_mdn_url
    elsif params["mdn_url"] == "false"
      features = features.has_no_mdn_url
    end

    @feature_count = features.count
    @features = features.page(params[:page])

    @browsers = Rails.configuration.browsers
    
    [:qq_android, :uc_android, :uc_chinese_android, :samsunginternet_android].each do |browser|
      @browsers.delete(browser)
    end
  end
end
