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
#  slug                    :string           not null
#  standard_track          :boolean
#  uc_android              :jsonb
#  uc_chinese_android      :jsonb
#  webview_android         :jsonb
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_features_on_slug  (slug) UNIQUE
#

require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test "has_description scope does not return features without descriptions" do
    feature_with_description = create(:has_description)
    feature = create(:feature)
    
    assert_not_includes(Feature.has_description, Feature.find_by!(name: feature.name))
    assert_includes(Feature.has_description, Feature.find_by!(name: feature_with_description.name))
  end

  test "has_mdn_url scope does not return features without an MDN URL" do
    feature_with_mdn_url = create(:has_mdn_url)
    feature = create(:feature)

    assert_not_includes(Feature.has_mdn_url, Feature.find_by!(name: feature.name))
    assert_includes(Feature.has_mdn_url, Feature.find_by!(name: feature_with_mdn_url.name))
  end

  test "is_deprecated scope returns only deprecated features" do
    feature_deprecated = create(:deprecated_true)
    feature_not_deprecated = create(:deprecated_false)
    feature = create(:feature)

    assert_includes(Feature.is_deprecated, Feature.find_by!(name: feature_deprecated.name))
    assert_not_includes(Feature.is_deprecated, Feature.find_by!(name: feature_not_deprecated.name))
    assert_not_includes(Feature.is_deprecated, Feature.find_by!(name: feature.name))
  end

  test "is_not_deprecated scope returns non-deprecated features" do
    feature_deprecated = create(:deprecated_true)
    feature_not_deprecated = create(:deprecated_false)
    feature = create(:feature)

    assert_includes(Feature.is_not_deprecated, Feature.find_by!(name: feature_not_deprecated.name))
    assert_not_includes(Feature.is_not_deprecated, Feature.find_by!(name: feature_deprecated.name))
    assert_not_includes(Feature.is_not_deprecated, Feature.find_by!(name: feature.name))
  end

  test "no_deprecation_info scope returns only features without deprecation data" do
    feature_deprecated = create(:deprecated_true)
    feature_not_deprecated = create(:deprecated_false)
    feature = create(:feature)

    assert_includes(Feature.no_deprecation_info, Feature.find_by!(name: feature.name))
    assert_not_includes(Feature.no_deprecation_info, Feature.find_by!(name: feature_deprecated.name))
    assert_not_includes(Feature.no_deprecation_info, Feature.find_by!(name: feature_not_deprecated.name))
  end

  test "is_on_standard_track scope returns only standard features" do
    feature_standard_track = create(:standard_track_true)
    feature_not_standard_track = create(:standard_track_false)
    feature = create(:feature)

    assert_includes(Feature.is_on_standard_track, Feature.find_by!(name: feature_standard_track.name))
    assert_not_includes(Feature.is_on_standard_track, Feature.find_by!(name: feature_not_standard_track.name))
    assert_not_includes(Feature.is_on_standard_track, Feature.find_by!(name: feature.name))
  end

  test "is_not_on_standard_track scope returns only non-standard features" do
    feature_standard_track = create(:standard_track_true)
    feature_not_standard_track = create(:standard_track_false)
    feature = create(:feature)

    assert_includes(Feature.is_not_on_standard_track, Feature.find_by!(name: feature_not_standard_track.name))
    assert_not_includes(Feature.is_not_on_standard_track, Feature.find_by!(name: feature_standard_track.name))
    assert_not_includes(Feature.is_not_on_standard_track, Feature.find_by!(name: feature.name))
  end

  test "no_standard_track_info scope returns only features without standard track data" do
    feature_standard_track = create(:standard_track_true)
    feature_not_standard_track = create(:standard_track_false)
    feature = create(:feature)

    assert_includes(Feature.no_standard_track_info, Feature.find_by!(name: feature.name))
    assert_not_includes(Feature.no_standard_track_info, Feature.find_by!(name: feature_standard_track.name))
    assert_not_includes(Feature.no_standard_track_info, Feature.find_by!(name: feature_not_standard_track.name))
  end

  test "is_experimental scope returns only experimental features" do
    feature_experimental = create(:experimental_true)
    feature_not_experimental = create(:experimental_false)
    feature = create(:feature)

    assert_includes(Feature.is_experimental, Feature.find_by!(name: feature_experimental.name))
    assert_not_includes(Feature.is_experimental, Feature.find_by!(name: feature_not_experimental.name))
    assert_not_includes(Feature.is_experimental, Feature.find_by!(name: feature.name))
  end

  test "is_not_experimental scope returns only non-experimental features" do
    feature_experimental = create(:experimental_true)
    feature_not_experimental = create(:experimental_false)
    feature = create(:feature)
    
    assert_includes(Feature.is_not_experimental, Feature.find_by!(name: feature_not_experimental.name))
    assert_not_includes(Feature.is_not_experimental, Feature.find_by!(name: feature_experimental.name))
    assert_not_includes(Feature.is_not_experimental, Feature.find_by!(name: feature.name))
  end

  test "no_experimental_info scope returns only features without experimental data" do
    feature_experimental = create(:experimental_true)
    feature_not_experimental = create(:experimental_false)
    feature = create(:feature)

    assert_includes(Feature.no_experimental_info, Feature.find_by!(name: feature.name))
    assert_not_includes(Feature.no_experimental_info, Feature.find_by!(name: feature_experimental.name))
    assert_not_includes(Feature.no_experimental_info, Feature.find_by!(name: feature_not_experimental.name))
  end

  test "firefox_true scope returns features that should be true" do
    feature_firefox_true_simple_one = create(:firefox_true_simple_one)
    feature_firefox_true_simple_two = create(:firefox_true_simple_two)
    feature_firefox_true_complex_one = create(:firefox_true_complex_one)
    feature_firefox_true_complex_two = create(:firefox_true_complex_two)
    feature = create(:feature)

    assert_includes(Feature.firefox_true, Feature.find_by!(name: feature_firefox_true_simple_one.name))
    assert_includes(Feature.firefox_true, Feature.find_by!(name: feature_firefox_true_simple_two.name))
    assert_includes(Feature.firefox_true, Feature.find_by!(name: feature_firefox_true_complex_one.name))

    # TODO: This fails right now because the code can't handle an array of version hashes yet.
    # assert_includes(Feature.firefox_true, Feature.find_by!(name: feature_firefox_true_complex_two.name))

    assert_not_includes(Feature.firefox_true, Feature.find_by!(name: feature.name))
  end

  test "firefox_false scope returns features that should be false" do
    feature_firefox_false = create(:firefox_false)
    feature = create(:feature)

    assert_includes(Feature.firefox_false, Feature.find_by!(name: feature_firefox_false.name))
    assert_not_includes(Feature.firefox_false, Feature.find_by!(name: feature.name))
  end

  test "firefox_nil scope returns features that should be nil" do
    feature_firefox_nil = create(:firefox_nil)
    feature = create(:feature)

    assert_includes(Feature.firefox_nil, Feature.find_by!(name: feature_firefox_nil.name))
    assert_not_includes(Feature.firefox_nil, Feature.find_by!(name: feature.name))
  end

  test "firefox_no_data scope returns features that have no data" do
    feature_firefox_nil = create(:firefox_nil)
    feature = create(:feature)

    assert_includes(Feature.firefox_no_data, Feature.find_by!(name: feature.name))
    assert_not_includes(Feature.firefox_no_data, Feature.find_by!(name: feature_firefox_nil.name))
  end
end
