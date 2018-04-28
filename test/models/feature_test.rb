# == Schema Information
#
# Table name: features
#
#  id                      :bigint(8)        not null, primary key
#  chrome                  :jsonb
#  chrome_android          :jsonb
#  deprecated              :boolean
#  description             :string
#  edge                    :jsonb
#  edge_mobile             :jsonb
#  experimental            :boolean
#  firefox                 :jsonb
#  firefox_android         :jsonb
#  ie                      :jsonb
#  mdn_url                 :string
#  name                    :string
#  nodejs                  :jsonb
#  opera                   :jsonb
#  qq_android              :jsonb
#  safari                  :jsonb
#  safari_ios              :jsonb
#  samsunginternet_android :jsonb
#  standard_track          :boolean
#  uc_android              :jsonb
#  uc_chinese_android      :jsonb
#  webview_android         :jsonb
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test "has_description scope does not return features without descriptions" do
    feature_with_description = create(:feature_with_description)
    feature = create(:feature)
    
    refute_includes(Feature.has_description, Feature.find_by!(name: feature.name))
    assert_includes(Feature.has_description, Feature.find_by!(name: feature_with_description.name))
  end

  test "has_mdn_url scope does not return features without an MDN URL" do
    feature_with_mdn_url = create(:feature_with_mdn_url)
    feature = create(:feature)

    refute_includes(Feature.has_mdn_url, Feature.find_by!(name: feature.name))
    assert_includes(Feature.has_mdn_url, Feature.find_by!(name: feature_with_mdn_url.name))
  end

  test "is_deprecated scope returns only deprecated features" do
    feature_deprecated = create(:feature_deprecated)
    feature_not_deprecated = create(:feature_not_deprecated)
    feature = create(:feature)

    assert_includes(Feature.is_deprecated, Feature.find_by!(name: feature_deprecated.name))
    refute_includes(Feature.is_deprecated, Feature.find_by!(name: feature_not_deprecated.name))
    refute_includes(Feature.is_deprecated, Feature.find_by!(name: feature.name))
  end

  test "is_not_deprecated scope returns non-deprecated features" do
    feature_deprecated = create(:feature_deprecated)
    feature_not_deprecated = create(:feature_not_deprecated)
    feature = create(:feature)

    assert_includes(Feature.is_not_deprecated, Feature.find_by!(name: feature_not_deprecated.name))
    refute_includes(Feature.is_not_deprecated, Feature.find_by!(name: feature_deprecated.name))
    refute_includes(Feature.is_not_deprecated, Feature.find_by!(name: feature.name))
  end

  test "no_deprecation_info scope returns only features without deprecation data" do
    feature_deprecated = create(:feature_deprecated)
    feature_not_deprecated = create(:feature_not_deprecated)
    feature = create(:feature)

    assert_includes(Feature.no_deprecation_info, Feature.find_by!(name: feature.name))
    refute_includes(Feature.no_deprecation_info, Feature.find_by!(name: feature_deprecated.name))
    refute_includes(Feature.no_deprecation_info, Feature.find_by!(name: feature_not_deprecated.name))
  end

  test "is_on_standard_track scope returns only standard features" do
    feature_standard_track = create(:feature_standard_track)
    feature_not_standard_track = create(:feature_not_standard_track)
    feature = create(:feature)

    assert_includes(Feature.is_on_standard_track, Feature.find_by!(name: feature_standard_track.name))
    refute_includes(Feature.is_on_standard_track, Feature.find_by!(name: feature_not_standard_track.name))
    refute_includes(Feature.is_on_standard_track, Feature.find_by!(name: feature.name))
  end

  test "is_not_on_standard_track scope returns only non-standard features" do
    feature_standard_track = create(:feature_standard_track)
    feature_not_standard_track = create(:feature_not_standard_track)
    feature = create(:feature)

    assert_includes(Feature.is_not_on_standard_track, Feature.find_by!(name: feature_not_standard_track.name))
    refute_includes(Feature.is_not_on_standard_track, Feature.find_by!(name: feature_standard_track.name))
    refute_includes(Feature.is_not_on_standard_track, Feature.find_by!(name: feature.name))
  end

  test "no_standard_track_info scope returns only features without standard track data" do
    feature_standard_track = create(:feature_standard_track)
    feature_not_standard_track = create(:feature_not_standard_track)
    feature = create(:feature)

    assert_includes(Feature.no_standard_track_info, Feature.find_by!(name: feature.name))
    refute_includes(Feature.no_standard_track_info, Feature.find_by!(name: feature_standard_track.name))
    refute_includes(Feature.no_standard_track_info, Feature.find_by!(name: feature_not_standard_track.name))
  end

  test "is_experimental scope returns only experimental features" do
    feature_experimental = create(:feature_experimental)
    feature_not_experimental = create(:feature_not_experimental)
    feature = create(:feature)

    assert_includes(Feature.is_experimental, Feature.find_by!(name: feature_experimental.name))
    refute_includes(Feature.is_experimental, Feature.find_by!(name: feature_not_experimental.name))
    refute_includes(Feature.is_experimental, Feature.find_by!(name: feature.name))
  end

  test "is_not_experimental scope returns only non-experimental features" do
    feature_experimental = create(:feature_experimental)
    feature_not_experimental = create(:feature_not_experimental)
    feature = create(:feature)
    
    assert_includes(Feature.is_not_experimental, Feature.find_by!(name: feature_not_experimental.name))
    refute_includes(Feature.is_not_experimental, Feature.find_by!(name: feature_experimental.name))
    refute_includes(Feature.is_not_experimental, Feature.find_by!(name: feature.name))
  end

  test "no_experimental_info scope returns only features without experimental data" do
    feature_experimental = create(:feature_experimental)
    feature_not_experimental = create(:feature_not_experimental)
    feature = create(:feature)
    
    assert_includes(Feature.no_experimental_info, Feature.find_by!(name: feature.name))
    refute_includes(Feature.no_experimental_info, Feature.find_by!(name: feature_experimental.name))
    refute_includes(Feature.no_experimental_info, Feature.find_by!(name: feature_not_experimental.name))
  end
end
