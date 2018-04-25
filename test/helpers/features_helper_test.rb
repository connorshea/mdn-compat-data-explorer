require 'test_helper'

class FeaturesHelperTest < ActionView::TestCase
  test 'version_added_parser produces yes when firefox version_added is true' do
    feature = Feature.find_by!(firefox: {"version_added": true})

    html = Nokogiri::HTML(version_added_parser(feature.firefox).to_s)

    assert_equal(html.css('td').text, "Yes")
  end

  test 'version_added_parser produces no when firefox version_added is false' do
    feature = Feature.find_by!(firefox: {"version_added": false})

    html = Nokogiri::HTML(version_added_parser(feature.firefox).to_s)

    assert_equal(html.css('td').text, "No")
  end

  test 'version_added_parser produces ? when firefox version_added is null' do
    feature = Feature.find_by!(firefox: {"version_added": nil})

    html = Nokogiri::HTML(version_added_parser(feature.firefox).to_s)

    assert_equal(html.css('td').text, "?")
  end

  test 'version_added_parser produces 1 when firefox version_added is "1"' do
    feature = Feature.find_by!(firefox: {"version_added": "1"})

    html = Nokogiri::HTML(version_added_parser(feature.firefox).to_s)

    assert_equal(html.css('td').text, "1")
  end
end
