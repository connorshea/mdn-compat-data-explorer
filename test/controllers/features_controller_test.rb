require 'test_helper'

class FeaturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get features_url
    assert_response :success
  end
end
