require 'test_helper'

class FeaturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get features_index_url
    assert_response :success
  end

end
