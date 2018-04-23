class Feature < ApplicationRecord
  include PgSearch

  validates :name, presence: true, uniqueness: true

  paginates_per 50

  pg_search_scope :search,
    against: [:name],
    using: {
      tsearch: { prefix: true },
      trigram: { threshold: 0.3 }
    }
end
