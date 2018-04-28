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

class Browser < ApplicationRecord
  store_accessor :releases, :release_date, :release_notes, :status

  validates :browser_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :releases, uniqueness: true
end
