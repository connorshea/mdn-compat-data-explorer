require "application_system_test_case"

class FeaturesTest < ApplicationSystemTestCase
  test "features page shows all features by default" do
    visit features_url

    assert_selector(".feature-card", count: Feature.count)
  end
  
  test "search works" do
    visit features_url
    fill_in "query", with: "bare_feature"
    click_on "Search"

    assert_selector("h5 span", text: "css.bare_feature")
  end
  
  test "description displays" do
    visit features_url
    fill_in "query", with: "standard_feature_with_description"
    click_on "Search"

    assert_selector("p.feature-description")
  end

  test "MDN URL displays" do
    visit features_url
    fill_in "query", with: "feature_with_mdn_url"
    click_on "Search"

    assert_selector("a.mdn-link")
  end

  test "Nothing displays for bare feature" do
    visit features_url
    fill_in "query", with: "bare_feature"
    click_on "Search"

    assert_no_selector("a.mdn-link")
    assert_no_selector("p.feature-description")
    assert_no_selector("abbr.status-standard")
    assert_no_selector("abbr.status-nonstandard")
    assert_no_selector("abbr.status-experimental")
    assert_no_selector("abbr.status-deprecated")
  end

  test "standard feature icon displays" do
    visit features_url
    fill_in "query", with: "standard_feature_with_description"
    click_on "Search"

    within(:css, '.feature-card-css-standard_feature_with_description') do
      assert_selector("abbr.status-standard")
      assert_no_selector("abbr.status-nonstandard")
    end
  end

  test "nonstandard feature icon displays" do
    visit features_url
    fill_in "query", with: "experimental_nonstandard_subfeature"
    click_on "Search"

    within(:css, '.feature-card-css-nonstandard_feature_with_description') do
      assert_selector("abbr.status-nonstandard")
      assert_no_selector("abbr.status-standard")
    end
  end

  test "experimental feature icon displays" do
    visit features_url
    fill_in "query", with: "experimental_feature"
    click_on "Search"

    assert_selector("abbr.status-experimental")
  end

  test "deprecated feature icon displays" do
    visit features_url
    fill_in "query", with: "deprecated_feature_with_description"
    click_on "Search"

    assert_selector("abbr.status-deprecated")
  end

  test "filter to CSS should list all CSS features" do
    visit features_url
    # Check the checkbox for 'CSS'
    check('CSS')
    click_on "Search"

    assert_selector(".feature-card", count: Feature.css.count)
  end
end
