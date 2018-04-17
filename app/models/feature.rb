class Feature < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
