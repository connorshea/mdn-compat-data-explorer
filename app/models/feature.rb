class Feature < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  paginates_per 50
end
