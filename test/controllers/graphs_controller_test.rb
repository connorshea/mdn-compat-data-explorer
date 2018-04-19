require 'test_helper'

class GraphsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get graphs_url
    assert_response :success
  end

end
