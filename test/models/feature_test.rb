require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test "has_description scope does not return features without descriptions" do
    # The description attribute can only be either a string or nil, no need
    # to test any other conditions.
    refute_includes(Feature.has_description, Feature.find_by!(description: nil))
  end

  test "has_mdn_url scope does not return features without an MDN URL" do
    # The mdn_url attribute can only be either a string or nil, no need
    # to test any other conditions.
    refute_includes(Feature.has_mdn_url, Feature.find_by!(mdn_url: nil))
  end

  test "is_deprecated scope returns only deprecated features" do
    assert_includes(Feature.is_deprecated, Feature.find_by!(deprecated: true))
    refute_includes(Feature.is_deprecated, Feature.find_by!(deprecated: false))
    refute_includes(Feature.is_deprecated, Feature.find_by!(deprecated: nil))
  end

  test "is_on_standard_track scope returns only standard features" do
    assert_includes(Feature.is_on_standard_track, Feature.find_by!(standard_track: true))
    refute_includes(Feature.is_on_standard_track, Feature.find_by!(standard_track: false))
    refute_includes(Feature.is_on_standard_track, Feature.find_by!(standard_track: nil))
  end

  test "is_not_on_standard_track scope returns only non-standard features" do
    assert_includes(Feature.is_not_on_standard_track, Feature.find_by!(standard_track: false))
    refute_includes(Feature.is_not_on_standard_track, Feature.find_by!(standard_track: true))
    refute_includes(Feature.is_not_on_standard_track, Feature.find_by!(standard_track: nil))
  end

  test "is_experimental scope returns only experimental features" do
    assert_includes(Feature.is_experimental, Feature.find_by!(experimental: true))
    refute_includes(Feature.is_experimental, Feature.find_by!(experimental: false))
    refute_includes(Feature.is_experimental, Feature.find_by!(experimental: nil))
  end
end
