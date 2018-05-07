class FeaturesController < ApplicationController
  def index
    @sticky_header = true

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

    # Handles filtering based on the presence of a description.
    if params["description"] == "true"
      features = features.has_description
    elsif params["description"] == "false"
      features = features.has_no_description
    end

    if params["deprecated"] == "true"
      features = features.is_deprecated
    elsif params["deprecated"] == "false"
      features = features.is_not_deprecated
    elsif params["deprecated"] == "no_info"
      features = features.no_deprecation_info
    end

    if params["experimental"] == "true"
      features = features.is_experimental
    elsif params["experimental"] == "false"
      features = features.is_not_experimental
    elsif params["experimental"] == "no_info"
      features = features.no_experimental_info
    end

    if params["standard_track"] == "true"
      features = features.is_on_standard_track
    elsif params["standard_track"] == "false"
      features = features.is_not_on_standard_track
    elsif params["standard_track"] == "no_info"
      features = features.no_standard_track_info
    end

    @feature_count = features.count

    if params["random"] == "true"
      features = features.order(Arel.sql('random()'))
    end

    @features = features.page(params[:page])

    @browsers = Rails.configuration.browsers
    
    [:qq_android, :uc_android, :uc_chinese_android, :samsunginternet_android].each do |browser|
      @browsers.delete(browser)
    end
  end
end
