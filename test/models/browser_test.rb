# == Schema Information
#
# Table name: browsers
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  releases   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  browser_id :string
#

require 'test_helper'

class BrowserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
