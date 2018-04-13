class Browser < ApplicationRecord
  store_accessor :releases, :release_date, :release_notes, :status

  validates :browser_id, presence: true
  validates :name, presence: true
end
