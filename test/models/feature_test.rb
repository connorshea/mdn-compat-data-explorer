require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test "number of features" do
    assert Feature.all.count == 12
  end
end
