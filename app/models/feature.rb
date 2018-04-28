# == Schema Information
#
# Table name: features
#
#  id                      :bigint(8)        not null, primary key
#  chrome                  :jsonb
#  chrome_android          :jsonb
#  deprecated              :boolean
#  description             :string
#  edge                    :jsonb
#  edge_mobile             :jsonb
#  experimental            :boolean
#  firefox                 :jsonb
#  firefox_android         :jsonb
#  ie                      :jsonb
#  mdn_url                 :string
#  name                    :string
#  nodejs                  :jsonb
#  opera                   :jsonb
#  qq_android              :jsonb
#  safari                  :jsonb
#  safari_ios              :jsonb
#  samsunginternet_android :jsonb
#  standard_track          :boolean
#  uc_android              :jsonb
#  uc_chinese_android      :jsonb
#  webview_android         :jsonb
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Feature < ApplicationRecord
  include PgSearch

  validates :name, presence: true, uniqueness: true

  paginates_per 50

  # Feature attribute scopes
  scope :has_mdn_url,              -> { where.not(mdn_url: nil) }
  scope :has_description,          -> { where.not(description: nil) }

  # Feature status scopes
  scope :is_deprecated,            -> { where(deprecated: true) }
  scope :is_not_deprecated,        -> { where(deprecated: false) }
  scope :no_deprecation_info,      -> { where(deprecated: nil) }
  scope :is_on_standard_track,     -> { where(standard_track: true) }
  scope :is_not_on_standard_track, -> { where(standard_track: false) }
  scope :no_standard_track_info,   -> { where(standard_track: nil) }
  scope :is_experimental,          -> { where(experimental: true) }
  scope :is_not_experimental,      -> { where(experimental: false) }
  scope :no_experimental_info,     -> { where(experimental: nil) }
  
  # Feature category scopes
  scope :api,           -> { where("name ~* ?", '^api.*') }
  scope :css,           -> { where("name ~* ?", '^css.*') }
  scope :html,          -> { where("name ~* ?", '^html.*') }
  scope :http,          -> { where("name ~* ?", '^http.*') }
  scope :javascript,    -> { where("name ~* ?", '^javascript.*') }
  scope :mathml,        -> { where("name ~* ?", '^mathml.*') }
  scope :svg,           -> { where("name ~* ?", '^svg.*') }
  scope :webdriver,     -> { where("name ~* ?", '^webdriver.*') }
  scope :webextensions, -> { where("name ~* ?", '^webextensions.*') }

  pg_search_scope :search,
    against: [:name],
    using: {
      tsearch: { prefix: true },
      trigram: { threshold: 0.3 }
    }
end
